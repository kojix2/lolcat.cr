require "colorize"
require "./options"

module Lolcat
  # The Lol module contains the core functionality for colorizing text with rainbow colors.
  #
  # This module provides methods to process text input (from strings or IO) and
  # apply rainbow colors to each character. It handles ANSI escape sequences,
  # animation effects, and various customization options.
  module Lol
    # Regular expression to match ANSI escape sequences and visible characters
    ANSI_ESCAPE = /((?:\e(?:[ -\/]+.|[\]PX^_][^\a\e]*|\[[0-?]*.|.))*)(.?)/m
    # Regular expression to match incomplete ANSI escape sequences at the end of a buffer
    INCOMPLETE_ESCAPE = /\e(?:[ -\/]*|[\]PX^_][^\a\e]*|\[[0-?]*)$/
    # Regular expression to match ANSI escape sequences for cursor movement
    ESCAPE_SEQUENCES = /\e\[[0-?]*[@JKPX]/

    # ANSI escape sequence to reset all terminal attributes
    RESET_ATTRIBUTES = "\e[m"
    # ANSI escape sequence to hide the cursor
    HIDE_CURSOR = "\e[?25l"
    # ANSI escape sequence to show the cursor
    SHOW_CURSOR = "\e[?25h"
    # ANSI escape sequence to reset terminal modes
    RESET_TERMINAL_MODES = "\e[?1;5;2004l"

    # Calculates RGB color values for a rainbow effect based on frequency and offset.
    #
    # This function uses sine waves with different phase shifts to generate
    # smooth transitions between colors in the rainbow spectrum.
    #
    # freq: Controls how quickly the colors change
    # offset: Position in the color cycle
    #
    # Returns a tuple of RGB values as UInt8 (0-255)
    def rainbow_color(freq : Float64, offset : Float64) : {UInt8, UInt8, UInt8}
      {((Math.sin(freq * offset + 0) + 1) * 127).to_u8,                # Red
       ((Math.sin(freq * offset + 2 * Math::PI / 3) + 1) * 127).to_u8, # Green
       ((Math.sin(freq * offset + 4 * Math::PI / 3) + 1) * 127).to_u8} # Blue
    end

    # Processes input and prints it with rainbow colors.
    #
    # This is the main function for displaying colorized text to the terminal.
    # It handles both string and IO inputs, applies rainbow colors, and manages
    # terminal state (cursor visibility, etc.).
    #
    # input: The text to colorize (either a String or IO)
    # options: Configuration options for the colorization
    def lol_cat(input : (IO | String), options : Options)
      options.force? ? Colorize.enabled = true : Colorize.on_tty_only!
      print HIDE_CURSOR if options.animate?
      lol(input, options) { |line| print line }
    ensure
      if STDOUT.tty? || options.force?
        print "#{RESET_ATTRIBUTES}#{SHOW_CURSOR}#{RESET_TERMINAL_MODES}"
      end
    end

    # Processes a string input and yields each colorized line.
    #
    # This is a convenience overload that converts a string to an IO::Memory
    # and delegates to the IO version of this method.
    #
    # input: The string to process
    # options: Configuration options for the colorization
    # yield: Each processed line is yielded to the block
    def lol(input : String, options : Options, &)
      lol(IO::Memory.new(input), options) { |line| yield line }
    end

    # Processes an IO input and yields each colorized line.
    #
    # This method reads from the input IO in chunks, processes each line,
    # and yields the colorized output. It handles ANSI escape sequences
    # and maintains line numbering for proper rainbow color progression.
    #
    # input: The IO to read from
    # options: Configuration options for the colorization
    # yield: Each processed line is yielded to the block
    def lol(input : IO, options : Options, &)
      buffer = IO::Memory.new
      chunk = Bytes.new(4096)
      line_number = 0
      bytes_read = 0
      cursor_position = 0

      while (bytes_read = input.read(chunk)) > 0
        buffer.write(chunk[0, bytes_read])
        buffer_content = buffer.to_s

        next if buffer_content =~ INCOMPLETE_ESCAPE

        buffer_content.each_line(chomp: false) do |line|
          line_number, cursor_position =
            clip_tail(line, line_number, cursor_position, options) { |lin| yield lin }
        end

        buffer.clear
      end
    end

    # Processes a line of text, handling newlines and applying rainbow colors.
    #
    # This private method handles the details of processing each line, including
    # newline handling and determining whether to apply animation effects.
    #
    # line: The line of text to process
    # line_number: The current line number (used for color progression)
    # cursor_position: The current cursor position (used for color progression)
    # options: Configuration options for the colorization
    # yield: The processed line is yielded to the block
    #
    # Returns a tuple with the updated line number and cursor position
    private def clip_tail(line, line_number, cursor_position, options, &) : {Int32, Int32}
      if flag = line.ends_with?("\n")
        # "\r\n" should be `chomped` to "\r" here! not ""
        line = line.delete_at(-1)
      end

      if options.animate?
        handle_animation(line, options, line_number, cursor_position) { |lin| yield lin }
      else
        yield rainbow_line(line, options, line_number, cursor_position)
      end

      if flag
        yield "\n"
        {line_number + 1, 0}
      else
        # tab is counted as 1 char for now
        {line_number, cursor_position + line.size}
      end
    end

    # Handles the animation effect for a line of text.
    #
    # This method creates an animation effect by repeatedly rendering the same line
    # with different color offsets, creating a moving rainbow effect.
    #
    # line: The line of text to animate
    # options: Configuration options for the animation
    # line_number: The current line number (used for color progression)
    # cursor_position: The current cursor position (used for color progression)
    # yield: Each frame of the animation is yielded to the block
    private def handle_animation(line : String, options : Options, line_number : Int32, cursor_position : Int32, &)
      offset = options.offset + line_number + cursor_position / options.spread
      yield "\e7#{rainbow_line(line, options, offset)}"
      line = line.gsub(ESCAPE_SEQUENCES, "")
      (options.duration - 1).times do
        offset += options.spread
        yield "\e8#{rainbow_line(line, options, offset)}"
        sleep_duration(options)
      end
    end

    # Calculates and sleeps for the appropriate duration between animation frames.
    #
    # This method converts the speed option to a time span and sleeps for that duration.
    #
    # options: Configuration options containing the animation speed
    private def sleep_duration(options : Options)
      sleep Time::Span.new(nanoseconds: (1_000_000_000 / options.speed).to_i)
    end

    # Applies rainbow colors to a line of text based on line number and position.
    #
    # This overload calculates the appropriate offset based on line number and position,
    # then delegates to the offset-based version of this method.
    #
    # line: The line of text to colorize
    # options: Configuration options for the colorization
    # index: The line number (used for color progression)
    # pos: The cursor position (used for color progression)
    #
    # Returns a string with rainbow colors applied
    def rainbow_line(line : String, options : Options, index : Int32, pos : Int32) : String
      offset = options.offset + index + pos / options.spread
      rainbow_line(line, options, offset)
    end

    # Applies rainbow colors to a line of text based on a specific offset.
    #
    # This is the core method that applies rainbow colors to each character in a line.
    # It handles ANSI escape sequences and applies colors to visible characters only.
    #
    # line: The line of text to colorize
    # options: Configuration options for the colorization
    # offset: The color offset to use (determines the starting color)
    #
    # Returns a string with rainbow colors applied
    def rainbow_line(line : String, options : Options, offset : Float64) : String
      String.build do |str|
        char_position = 0

        line.scan(ANSI_ESCAPE) do |match|
          escape_sequence = match[1]? # Match group 1: ANSI escape codes
          character = match[2]?       # Match group 2: visible character or nil

          # Add ANSI escape sequences directly NOTE: Should be removed?
          str << escape_sequence if escape_sequence

          # Apply rainbow coloring to visible characters
          if character
            off_set = offset + char_position / options.spread
            color = rainbow_color(options.freq, off_set)

            if options.invert?
              str << character.colorize.back(*color)
            else
              str << character.colorize.fore(*color)
            end

            char_position += 1
          end
        end
      end
    end
  end
end
