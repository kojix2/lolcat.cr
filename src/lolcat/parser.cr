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
      on("-p", "--spread SPREAD", "Rainbow spread (default: 3.0)") do |spread_str|
        spread = spread_str.to_f
        if spread < 0.1
          STDERR.puts "[lolcat] ERROR: Spread must be >= 0.1"
          exit(1)
        end
        @opt.spread = spread
      end

      # Frequency
      on("-F", "--freq FREQ", "Rainbow frequency (default: 0.1)") do |freq|
        @opt.freq = freq.to_f
      end

      # Seed
      on("-S", "--seed SEED", "Rainbow seed, 0 = random (default: 0)") do |seed|
        @opt.seed = seed.to_i
      end

      # Animate
      on("-a", "--animate", "Enable psychedelics (default: false)") do
        @opt.animate = true
      end

      # Duration
      on("-d", "--duration DURATION", "Animation duration (default: 12)") do |duration_str|
        duration = duration_str.to_f
        if duration < 0.1
          STDERR.puts "[lolcat] ERROR: Duration must be >= 0.1"
          exit(1)
        end
        @opt.duration = duration
      end

      # Speed
      on("-s", "--speed SPEED", "Animation speed (default: 20.0)") do |speed_str|
        speed = speed_str.to_f
        if speed < 0.1
          STDERR.puts "[lolcat] ERROR: Speed must be >= 0.1"
          exit(1)
        end
        @opt.speed = speed
      end

      # Invert
      on("-i", "--invert", "Invert foreground and background (default: false)") do
        @opt.invert = true
      end

      # Truecolor
      on("-t", "--truecolor", "Enable 24-bit (truecolor) (default: false)") do
        @opt.truecolor = true
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
        STDERR.puts "[lolcat] ERROR: #{flag} is not a valid option."
        STDERR.puts self
        exit(1)
      end

      missing_option do |flag|
        STDERR.puts "[lolcat] ERROR: #{flag} option expects an argument."
        STDERR.puts self
        exit(1)
      end
    end

    def parse(args)
      super
      @opt
    end
  end
end
