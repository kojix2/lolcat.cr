require "colorize"
require "./options"

module Lolcat
  module Lol
    ANSI_ESCAPE       = /((?:\e(?:[ -\/]+.|[\]PX^_][^\a\e]*|\[[0-?]*.|.))*)(.?)/m
    INCOMPLETE_ESCAPE = /\e(?:[ -\/]*|[\]PX^_][^\a\e]*|\[[0-?]*)$/
    ESCAPE_SEQUENCES  = /\e\[[0-?]*[@JKPX]/

    RESET_ATTRIBUTES = "\e[m"
    HIDE_CURSOR      = "\e[?25l"
    SHOW_CURSOR      = "\e[?25h"

    RESET_TERMINAL_MODES = "\e[?1;5;2004l"

    def rainbow_color(freq : Float64, offset : Float64) : {UInt8, UInt8, UInt8}
      {((Math.sin(freq * offset + 0) + 1) * 127).to_u8,                # Red
       ((Math.sin(freq * offset + 2 * Math::PI / 3) + 1) * 127).to_u8, # Green
       ((Math.sin(freq * offset + 4 * Math::PI / 3) + 1) * 127).to_u8} # Blue
    end

    def lol_cat(input : (IO | String), options : Options)
      options.force? ? Colorize.enabled = true : Colorize.on_tty_only!
      print HIDE_CURSOR if options.animate?
      lol(input, options) { |line| print line }
    ensure
      if STDOUT.tty? || options.force?
        print "#{RESET_ATTRIBUTES}#{SHOW_CURSOR}#{RESET_TERMINAL_MODES}"
      end
    end

    def lol(input : String, options : Options, &)
      lol(IO::Memory.new(input), options) { |line| yield line }
    end

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

    private def sleep_duration(options : Options)
      sleep Time::Span.new(nanoseconds: (1_000_000_000 / options.speed).to_i)
    end

    def rainbow_line(line : String, options : Options, index : Int32, pos : Int32) : String
      offset = options.offset + index + pos / options.spread
      rainbow_line(line, options, offset)
    end

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
