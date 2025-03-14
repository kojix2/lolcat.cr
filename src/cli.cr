require "./lolcat/*"

module Lolcat
  # Command Line Interface for the lolcat program.
  #
  # This class handles the command line interface, including parsing arguments,
  # executing the appropriate action, and handling errors.
  class CLI
    include Lol

    # Whether to enable debug mode (shows stack traces on errors)
    class_property? debug : Bool = false

    # The command line argument parser
    getter parser : Parser

    # The options parsed from command line arguments
    getter option : Options

    # Initializes the CLI with a parser and default options.
    #
    # Sets up a termination handler to reset terminal modes when the program
    # is interrupted.
    def initialize
      @parser = Lolcat::Parser.new
      @option = Options.new

      Process.on_terminate do
        if STDOUT.tty? || @option.force?
          # reset terminal modes
          # FIXME: This is not enough
          # The problem remains when Ctrl+C while executing the following commands
          # sl | bin/lolcat
          print "#{RESET_ATTRIBUTES}#{SHOW_CURSOR}#{RESET_TERMINAL_MODES}"
        end
        exit(1)
      end
    end

    # Parses command line arguments and updates the options.
    #
    # args: The command line arguments to parse (defaults to ARGV)
    #
    # Returns the updated options
    def parse_args(args = ARGV)
      @option = parser.parse(args)
    end

    # Runs the program with the parsed options.
    #
    # This is the main entry point that executes the appropriate action
    # based on the parsed command line arguments.
    def run
      parse_args
      case option.action
      when Action::Lolcat
        run_lolcat
      when Action::Version
        print_version
      when Action::Help
        print_help
      else
        raise ArgumentError.new("Invalid action: #{option.action}")
      end
    rescue ex
      handle_error(ex)
    end

    # Executes the main lolcat functionality.
    #
    # Processes input from ARGF (files specified on the command line or stdin)
    # and displays it with rainbow colors.
    def run_lolcat
      lol_cat(ARGF, option)
    end

    # Prints the version information.
    def print_version
      puts "lolcat version #{Lolcat::VERSION}"
    end

    # Prints the help message with rainbow colors.
    def print_help
      help_message = "#{parser.help_message}\n"
      lol_cat(help_message, option)
    end

    # Handles exceptions that occur during execution.
    #
    # Prints error messages to stderr and optionally includes stack traces
    # when debug mode is enabled.
    #
    # ex: The exception that occurred
    private def handle_error(ex : Exception)
      STDERR.puts "\n[lolcat] ERROR: #{ex.class} #{ex.message}"
      STDERR.puts "\n#{ex.backtrace.join("\n")}" if CLI.debug?
      exit(1)
    end
  end
end

Lolcat::CLI.new.run
