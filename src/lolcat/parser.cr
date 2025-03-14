require "option_parser"
require "./options"
require "./action"

module Lolcat
  # Command line argument parser for the lolcat program.
  #
  # This class extends Crystal's OptionParser to handle lolcat-specific
  # command line options and convert them into an Options struct.
  class Parser < OptionParser
    # The options object that will be populated with parsed values
    getter opt : Options

    # The formatted help message string
    property help_message : String

    # Initializes the parser with all supported command line options.
    #
    # Sets up all the command line options that lolcat supports and
    # their corresponding handlers.
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

      # Seed
      on("-S", "--seed SEED", "Rainbow offset (default: random)") do |seed_str|
        seed = seed_str.to_f64
        offset = seed % 256
        @opt.offset = offset
      end

      # Animate
      on("-a", "--animate", "Enable psychedelics") do
        @opt.animate = true
      end

      # Duration
      on("-d", "--duration DURATION", "Animation duration (default: #{opt.duration})") do |duration_str|
        duration = duration_str.to_i
        @opt.duration = duration
      end

      # Speed
      on("-s", "--speed SPEED", "Animation speed (default: #{opt.speed})") do |speed_str|
        speed = speed_str.to_f
        @opt.speed = speed
      end

      # Invert
      on("-i", "--invert", "Invert fg and bg") do
        @opt.invert = true
      end

      # Force
      on("-f", "--force", "Force color even when stdout is not a tty") do
        @opt.force = true
      end

      # Debug
      on("-D", "--debug", "Enable debug mode") do
        Lolcat::CLI.debug = true
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
        raise InvalidOption.new(flag)
      end

      missing_option do |flag|
        STDERR.puts self
        raise MissingOption.new(flag)
      end
    end

    # Parses the provided command line arguments.
    #
    # Processes the command line arguments and updates the options object
    # with the parsed values.
    #
    # args: The command line arguments to parse
    #
    # Returns the updated Options object
    def parse(args)
      super
      @opt
    end
  end
end
