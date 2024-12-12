require "./lolcat/*"

module Lolcat
  class CLI
    include Lol

    class_property? debug : Bool = false

    getter parser : Parser
    getter option : Options

    def initialize
      @parser = Lolcat::Parser.new
      @option = Options.new
    end

    def parse_args(args = ARGV)
      @option = parser.parse(args)
    end

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

    def run_lolcat
      lol_cat(ARGF, option)
    end

    def print_version
      puts "lolcat version #{Lolcat::VERSION}"
    end

    def print_help
      help_message = "#{parser.help_message}\n"
      lol_cat(help_message, option)
    end

    private def handle_error(ex : Exception)
      if STDOUT.tty? || options.force?
        # If the function lol#lol_cat passes through rescue, it is a double call.
        # However, errors that do not pass lol_cat must also be handled.
        print "#{Lol::RESET_ATTRIBUTES}#{Lol::SHOW_CURSOR}#{Lol::RESET_TERMINAL_MODES}"
      end
      STDERR.puts "\n[lolcat] ERROR: #{ex.class} #{ex.message}"
      STDERR.puts "\n#{ex.backtrace.join("\n")}" if CLI.debug?
      exit(1)
    end
  end
end

Lolcat::CLI.new.run
