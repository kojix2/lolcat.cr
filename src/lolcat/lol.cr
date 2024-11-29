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
        print "\e[?25l"
      end

      lol(input, options) do |line|
        print line
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
            line = line.delete_at(-1)
            if options.animate?
              handle_animation(line, options, line_number, cursor_position) do |line|
                yield line
              end
            else
              yield "#{rainbow_line(line, line_number, cursor_position, options)}"
            end
            yield "\n"
            line_number += 1
            cursor_position = 0
          else
            if options.animate?
              handle_animation(line, options, line_number, cursor_position) do |line|
                yield line
              end
            else
              yield rainbow_line(line, line_number, cursor_position, options)
            end
            cursor_position += line.size # tab width is 1
          end
        end

        buffer.clear
      end
    end

    private def handle_animation(line : String, options : Options, line_number : Int32, cursor_position : Int32, &)
      offset = options.offset + line_number + cursor_position / options.spread
      yield "\e7#{rainbow_line(line, offset, options)}"
      line = remove_escape_sequences(line)
      (options.duration - 1).times do
        offset += options.spread
        yield "\e8#{rainbow_line(line, offset, options)}"
        sleep_duration(options)
      end
    end

    private def remove_escape_sequences(s : String)
      s.gsub(/\e\[[0-?]*[@JKPX]/, "")
    end

    private def sleep_duration(options : Options)
      sleep Time::Span.new(nanoseconds: (1_000_000_000 / options.speed).to_i)
    end

    def rainbow_line(line : String, offset : Float64, options : Options) : String
      String.build do |str|
        char_position = 0

        line.scan(ANSI_ESCAPE) do |match|
          escape_sequence = match[1]? # Match group 1: ANSI escape codes
          character = match[2]?       # Match group 2: visible character or nil

          # Add ANSI escape sequences directly
          if escape_sequence
            str << escape_sequence
          end

          # Apply rainbow coloring to visible characters
          if character
            off_set = offset + char_position / options.spread
            color = rainbow_color(off_set, options.freq)

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

    def rainbow_line(line : String, index : Int32, pos : Int32, options : Options) : String
      offset = get_offset(options.offset, index, pos, options.spread)
      rainbow_line(line, offset, options)
    end

    def rainbow_color(offset : Float64, freq : Float64) : {UInt8, UInt8, UInt8}
      # Calculate RGB color using sine waves
      red = ((Math.sin(freq * offset + 0) + 1) * 127).to_u8
      green = ((Math.sin(freq * offset + 2 * Math::PI / 3) + 1) * 127).to_u8
      blue = ((Math.sin(freq * offset + 4 * Math::PI / 3) + 1) * 127).to_u8
      {red, green, blue}
    end

    private def get_offset(offset : Float64, index : Int32, pos : Int32, spread : Float64) : Float64
      offset + index + pos / spread
    end
  end
end
