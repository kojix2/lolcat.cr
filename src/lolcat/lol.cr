require "colorize"
require "./options"

module Lolcat
  module Lol
    ANSI_ESCAPE = /((?:\e(?:[ -\/]+.|[\]PX^_][^\a\e]*|\[[0-?]*.|.))*)(.?)/m

    def lol_cat(input : (IO | String), options : Options)
      if options.force?
        Colorize.enabled = true
      else
        Colorize.on_tty_only!
      end

      lol(input, options) do |line|
        print line
      end
    ensure
      if STDOUT.tty?
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
      input.each_line(chomp: false).with_index do |line, index|
        if line =~ /\n$/
          yield "#{rainbow_line(line.delete_at(-1), index, options)}\n"
        else
          yield rainbow_line(line, index, options)
        end
      end
    end

    def rainbow_line(line : String, index : Int32, options : Options) : String
      colored_line = String.build do |str|
        char_position = 0 # Track the visible character position

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
