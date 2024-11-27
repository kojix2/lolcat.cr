require "colorize"
require "./options"

module Lolcat
  module Lol
    ANSI_ESCAPE       = /((?:\e(?:[ -\/]+.|[\]PX^_][^\a\e]*|\[[0-?]*.|.))*)(.?)/m
    INCOMPLETE_ESCAPE = /\e(?:[ -\/]*|[\]PX^_][^\a\e]*|\[[0-?]*)$/

    def lol_cat(input : (IO | String), options : Options)
      if options.force?
        Colorize.enabled = true
      else
        Colorize.on_tty_only!
      end

      if options.animate?
        print "\e[?23l"
        lol_animate(input, options) do |line|
          print line
        end
      else
        lol(input, options) do |line|
          print line
        end
      end
    ensure
      if STDOUT.tty? || options.force?
        print "\e[m\e[?25h\e[?1;5;2004l"
      end
    end

    def lol(input : String, options : Options, &)
      io = IO::Memory.new(input)
      lol(io, options) do |line|
        yield line
      end
    end

    def lol(input : IO, options : Options, &)
      buffer = IO::Memory.new
      chunk = Bytes.new(4096)
      line_number = 0
      bytes_read = 0
      # FIXME: tab width is 1 for now
      cursor_position = 0

      while (bytes_read = input.read(chunk)) > 0
        buffer.write(chunk[0, bytes_read])
        buffer_content = buffer.to_s

        if buffer_content =~ INCOMPLETE_ESCAPE
          next
        end

        buffer_content.each_line(chomp: false) do |line|
          if line =~ /\n$/
            yield "#{rainbow_line(line.delete_at(-1), line_number, cursor_position, options)}\n"
            line_number += 1
            cursor_position = 0
          else
            yield rainbow_line(line, line_number, cursor_position, options)
            cursor_position += line.size # tab width is 1
          end
        end

        buffer.clear
      end
    end

    def lol_animate(input : String, options : Options, &)
      io = IO::Memory.new(input)
      lol_animate(io, options) do |line|
        yield line
      end
    end

    def lol_animate(input : IO, options : Options, &)
      buffer = IO::Memory.new
      chunk = Bytes.new(4096)
      line_number = 0
      bytes_read = 0
      # FIXME: tab width is 1 for now
      cursor_position = 0

      while (bytes_read = input.read(chunk)) > 0
        buffer.write(chunk[0, bytes_read])
        buffer_content = buffer.to_s

        if buffer_content =~ INCOMPLETE_ESCAPE
          next
        end

        buffer_content.each_line(chomp: false) do |line|
          print "\e7"
          real_line_number = line_number
          if line =~ /\n$/
            (1..options.duration).each do |i|
              print "\e8"
              yield "#{rainbow_line(line.delete_at(-1), line_number, cursor_position, options)}\n"
              line_number += 3
              cursor_position = 0
              sleep(Time::Span.new(nanoseconds: (1000000000/options.speed).to_i))
            end
          else
            yield rainbow_line(line, line_number, cursor_position, options)
            cursor_position += line.size # tab width is 1
          end
          line_number = real_line_number + 1
        end

        buffer.clear
      end
    end

    def rainbow_line(line : String, index : Int32, pos : Int32, options : Options) : String
      colored_line = String.build do |str|
        char_position = pos # Track the visible character position

        line.scan(ANSI_ESCAPE) do |match|
          escape_sequence = match[1]? # Match group 1: ANSI escape codes
          character = match[2]?       # Match group 2: visible character or nil

          # Add ANSI escape sequences directly
          if escape_sequence
            str << escape_sequence
          end

          # Apply rainbow coloring to visible characters
          if character
            offset = options.offset + index + char_position / options.spread
            color = rainbow_color(offset, options.freq)

            # Check invert option and apply colors accordingly
            if options.invert?
              str << character.colorize.back(*color)
            else
              str << character.colorize.fore(*color)
            end

            char_position += 1
          end
        end
      end

      colored_line
    end

    def rainbow_color(offset : Float64, freq : Float64) : {UInt8, UInt8, UInt8}
      # Calculate RGB color using sine waves
      red = ((Math.sin(freq * offset + 0) + 1) * 127).to_u8
      green = ((Math.sin(freq * offset + 2 * Math::PI / 3) + 1) * 127).to_u8
      blue = ((Math.sin(freq * offset + 4 * Math::PI / 3) + 1) * 127).to_u8
      {red, green, blue}
    end
  end
end
