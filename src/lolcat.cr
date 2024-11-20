# As a library

require "./lolcat/lol"

module Lolcat
  module Lol
    extend self
  end

  # Print a file with rainbow colors
  #
  # - If offset is not provided, it will be random.
  # - If force is true, it will force color output even if stdout is not a TTY.
  #
  def self.cat(path : Path, spread : Float64 = 3.0, freq : Float64 = 0.1, offset : Float64? = nil, invert : Bool = false, force : Bool = false) : Nil
    offset_f64 = offset || rand * 256.0
    options = Lolcat::Options.new(spread: spread, freq: freq, offset: offset_f64, invert: invert, force: force)

    File.open(path) do |file|
      Lolcat::Lol.lol_cat(file, options)
    end
  end

  # Print a string with rainbow colors
  #
  # - If offset is not provided, it will be random.
  # - If force is true, it will force color output even if stdout is not a TTY.
  #
  def self.cat(input : String, spread : Float64 = 3.0, freq : Float64 = 0.1, offset : Float64? = nil, invert : Bool = false, force : Bool = false) : Nil
    offset_f64 = offset || rand * 256.0
    options = Lolcat::Options.new(spread: spread, freq: freq, offset: offset_f64, invert: invert, force: force)

    Lolcat::Lol.lol_cat(input, options)
  end

  # Get a rainbow string line by line
  #
  # - If offset is not provided, it will be random.
  #
  # Example:
  # ```
  # Lolcat.lol("Rainbow string", invert: true) do |line|
  #   puts line
  # end
  # ```
  #
  def self.lol(input, spread : Float64 = 3.0, freq : Float64 = 0.1, offset : Float64? = nil, invert : Bool = false) : Nil
    offset_f64 = offset || rand * 256.0
    options = Lolcat::Options.new(spread: spread, freq: freq, offset: offset_f64, invert: invert, force: true)

    Lolcat::Lol.lol(input, options) do |line|
      yield line
    end
  end
end
