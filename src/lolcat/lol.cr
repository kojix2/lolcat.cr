require "colorize"
require "./options"

module Lolcat
  module Lol
    def lol(input : String, options : Options)
      io = IO::Memory.new(input)
      lol(io, options)
    end

    def lol(input : IO, options : Options)
      input.each_line.with_index do |line, index|
        puts rainbow_line(line.chomp, index, options)
      end
    end

    def rainbow_line(line : String, index : Int32, options : Options) : String
      # Generate rainbow-colored line
      colored_line = String.build do |str|
        line.each_char.with_index do |char, char_index|
          color = rainbow_color(index + char_index / options.spread, options.freq)
          str << char.colorize(*color)
        end
      end
      colored_line
    end

    def rainbow_color(offset : Float64, freq : Float64) : {UInt8, UInt8, UInt8}
      # Calculate RGB color using sine waves
      red = ((Math.sin(freq * offset + 0) + 1) * 127).to_u8
      green = ((Math.sin(freq * offset + 2 * Math::PI / 3) + 1) * 127).to_u8
      blue = ((Math.sin(freq * offset + 4 * Math::PI / 3) + 1) * 127).to_u8
      {red, green, blue} # Returns a hash usable with `colorize`
    end
  end
end
