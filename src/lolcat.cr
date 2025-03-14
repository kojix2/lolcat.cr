# As a library
#
# This file provides the main API for using lolcat as a library.
# It includes simplified methods for adding rainbow colors to text.

require "./lolcat/lol"

# The Lolcat module provides methods to colorize text with rainbow colors.
#
# This module serves as the main entry point for using lolcat as a library.
# It provides simplified methods for adding rainbow colors to text from files or strings.
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
  #   print line
  # end
  # ```
  #
  def self.lol(input, spread : Float64 = 3.0, freq : Float64 = 0.1, offset : Float64? = nil, invert : Bool = false, &) : Nil
    offset_f64 = offset || rand * 256.0
    options = Lolcat::Options.new(spread: spread, freq: freq, offset: offset_f64, invert: invert, force: true)

    Lolcat::Lol.lol(input, options) do |line|
      yield line
    end
  end
end
