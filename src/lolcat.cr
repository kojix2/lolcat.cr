# As a library

require "./lolcat/lol"

module Lolcat
  module Lol
    extend self
  end

  def self.cat(path : (Path | String), spread : Float64 = 3.0, freq : Float64 = 0.1, invert : Bool = false, force : Bool = false)
    options = Lolcat::Options.new(spread: spread, freq: freq, invert: invert, force: force)
    File.open(path) do |file|
      Lolcat::Lol.lol_cat(file, options)
    end
  end

  def self.lol(input, spread : Float64 = 3.0, freq : Float64 = 0.1, invert : Bool = false, force : Bool = false)
    options = Lolcat::Options.new(spread: spread, freq: freq, invert: invert, force: force)
    Lolcat::Lol.lol(input, options) do |line|
      yield line
    end
  end
end
