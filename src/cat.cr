require "./lolcat/*"

module Lolcat
  class Cat
    include Lol

    class_property debug : Bool = false

    getter parser : Parser
    getter option : Options

    def initialize
      @parser = Lolcat::Parser.new
      @option = parser.parse(ARGV)
    end

    def run
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
      lol(ARGF, option)
    end

    def print_version
      puts "lolcat version #{Lolcat::VERSION}"
    end

    def print_help
      lol(parser.help_message, option)
    end

    private def handle_error(ex : Exception)
      error_message = "\n[lolcat] ERROR: #{ex.class} #{ex.message}"
      error_message += "\n#{ex.backtrace.join("\n")}" if Cat.debug
      STDERR.puts error_message
      exit(1)
    end
  end
end

Lolcat::Cat.new.run
