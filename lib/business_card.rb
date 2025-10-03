# frozen_string_literal: true

require "yaml"
require "colorize"
require "tty-box"
require "tty-link"
require_relative "business_card/version"

module BusinessCard
  class Card
    class << self
      def display
        new.display
      end
    end

    def display
      clear_screen
      print_card
    end

    private

    def load_config
      config_file = File.expand_path("~/.plan")
      config_file = File.expand_path("~/.project") unless File.exist?(config_file)
      
      return {} unless File.exist?(config_file)
      
      begin
        YAML.load_file(config_file) || {}
      rescue => e
        puts "Warning: Could not load config file: #{e.message}".light_red
        {}
      end
    end

    def get_config(key, default)
      config = load_config
      config[key.to_s] || config[key.to_sym] || default
    end

    def clear_screen
      print "\e[2J\e[H"
    end

    def print_card
      content = build_card_content
      
      box = TTY::Box.frame(
        content,
        width: 60,
        border: :thick,
        title: { top_left: "Business Card" },
        style: {
          fg: :cyan,
          bg: :black,
          border: { fg: :bright_cyan }
        }
      )
      
      puts box
    end

    def build_card_content
      name = get_config(:name, "Thomas Powell")
      title = get_config(:title, "Senior Principal Software Engineer")
      company = get_config(:company, "Progress Chef")
      email = get_config(:email, "twilliampowell@gmail.com")
      github = get_config(:github, "github.com/stringsn88keys")
      linkedin = get_config(:linkedin, "linkedin.com/in/twilliampowell")
      website = get_config(:website, "https://thomaspowell.com")
      skills = get_config(:skills, "Ruby • Rails • DevOps • AWS Solutions Architect")

      <<~CARD
        #{piano_keys}

        #{name.bold.light_cyan}
        #{title.light_white} at #{company.light_white}

        #{email&.light_green if defined?(email)}
        #{github&.light_blue if defined?(github)}
        #{twitter&.light_blue if defined?(twitter)}
        #{linkedin&.light_blue if defined?(linkedin)}
        #{website&.light_blue if defined?(website)}

        Skills: #{skills&.light_black if defined?(skills)}
      CARD
    end

    def piano_keys
      <<~PIANO.light_white
        ╔═╦═╦═╦═╦═╦═╦═╦═╦═╦═╦═╦═╗
        ║ ║#{"█".black}║ ║#{"█".black}║ ║ ║#{"█".black}║ ║#{"█".black}║ ║#{"█".black}║ ║
        ║ ║#{"█".black}║ ║#{"█".black}║ ║ ║#{"█".black}║ ║#{"█".black}║ ║#{"█".black}║ ║
        ║ ╚═╝ ╚═╝ ║ ╚═╝ ╚═╝ ╚═╝ ║
        ║         ║             ║
        ╚═════════╩═════════════╝
      PIANO
    end
  end
end
