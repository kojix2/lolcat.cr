# As a library

require "./lolcat/lol"

module Lolcat
  module Lol
    extend self
  end

  # Print a file with rainbow colors
  #
  # @param path [Path] path to the file
  # @param spread [Float64] spread of the rainbow colors
  # @param freq [Float64] frequency of the rainbow colors
  # @param offset [Float64] offset of the rainbow colors (default: nil for random)
  # @param invert [Bool] invert the colors
  # @param force [Bool] force color output even if stdout is not a TTY
  # @return [Nil]

  def self.cat(path : Path, spread : Float64 = 3.0, freq : Float64 = 0.1, offset : Float64? = nil, invert : Bool = false, force : Bool = false) : Nil
    offset_f64 = offset || rand * 256.0
    options = Lolcat::Options.new(spread: spread, freq: freq, offset: offset_f64, invert: invert, force: force)

    File.open(path) do |file|
      Lolcat::Lol.lol_cat(file, options)
    end
  end

  # Print a string with rainbow colors
  #
  # @param input [String] input string
  # @param spread [Float64] spread of the rainbow colors
  # @param freq [Float64] frequency of the rainbow colors
  # @param offset [Float64] offset of the rainbow colors (default: nil for random)
  # @param invert [Bool] invert the colors
  # @param force [Bool] force color output even if stdout is not a TTY
  # @return [Nil]

  def self.cat(input : String, spread : Float64 = 3.0, freq : Float64 = 0.1, offset : Float64? = nil, invert : Bool = false, force : Bool = false) : Nil
    offset_f64 = offset || rand * 256.0
    options = Lolcat::Options.new(spread: spread, freq: freq, offset: offset_f64, invert: invert, force: force)

    Lolcat::Lol.lol_cat(input, options)
  end

  # Get a rainbow string line by line
  #
  # @param input [String] input string
  # @param spread [Float64] spread of the rainbow colors
  # @param freq [Float64] frequency of the rainbow colors
  # @param offset [Float64] offset of the rainbow colors (default: nil for random)
  # @param invert [Bool] invert the colors
  # @param force [Bool] force color output even if stdout is not a TTY
  # @yield [String] rainbow string line by line
  # @return [Nil]

  def self.lol(input, spread : Float64 = 3.0, freq : Float64 = 0.1, offset : Float64? = nil, invert : Bool = false, force : Bool = false) : Nil
    offset_f64 = offset || rand * 256.0
    options = Lolcat::Options.new(spread: spread, freq: freq, offset: offset_f64, invert: invert, force: force)

    Lolcat::Lol.lol(input, options) do |line|
      yield line
    end
  end
end
