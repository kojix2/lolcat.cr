require "option_parser"
require "./options"
require "./action"

module Lolcat
  class Parser < OptionParser
    getter opt : Options

    property help_message : String

    def initialize
      super()
      @opt = Options.new
      @help_message = ""

      self.banner = <<-BANNER

      Program: lolcat
      Usage:   lolcat [options] [FILE]...

      Options:
      BANNER

      # Spread
      on("-p", "--spread SPREAD", "Rainbow spread (default: #{opt.spread})") do |spread_str|
        spread = spread_str.to_f
        if spread < 0.1
          STDERR.puts "[lolcat] ERROR: Spread must be >= 0.1"
          exit(1)
        end
        @opt.spread = spread
      end

      # Frequency
      on("-F", "--freq FREQ", "Rainbow frequency (default: #{opt.freq})") do |freq_str|
        freq = freq_str.to_f
        @opt.freq = freq
      end

      # Invert
      on("-i", "--invert", "Invert fg and bg") do
        @opt.invert = true
      end

      # Force
      on("-f", "--force", "Force color output even if stdout is not a TTY (default: false)") do
        @opt.force = true
      end

      # Debug
      on("-D", "--debug", "Enable debug mode") do
        Lolcat::Cat.debug = true
      end

      # Version
      on("-v", "--version", "Print version and exit") do
        @opt.action = Action::Version
      end

      # Help
      on("-h", "--help", "Show this help message") do
        @help_message = self.to_s
        @opt.action = Action::Help
      end

      # Handle invalid options
      invalid_option do |flag|
        STDERR.puts self
        STDERR.puts "[lolcat] ERROR: #{flag} is not a valid option."
        exit(1)
      end

      missing_option do |flag|
        STDERR.puts self
        STDERR.puts "[lolcat] ERROR: #{flag} option expects an argument."
        exit(1)
      end
    end

    def parse(args)
      super
      @opt
    end
  end
end
