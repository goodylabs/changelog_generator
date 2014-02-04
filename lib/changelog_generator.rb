require 'net/smtp'
require 'yaml'
require "changelog_generator/version"

module ChangelogGenerator
  class Generator < Struct.new(:repo_directory, :config_file)
    
    attr_accessor :changelog

    def generate
      Dir.chdir(repo_directory) do
        `git pull --tags`
        raw_changelog = `git log last-deploy..HEAD --no-merges --format=%B`
        self.changelog = format(raw_changelog)
        send_mail
        `git tag -f last-deploy`
        `git push --force origin refs/tags/last-deploy:refs/tags/last-deploy`
      end
    end

    private

      def format(raw)
        commits = raw.split(/^$\n/)
        commits.map { |commit| "* " + commit }.join
      end

      def send_mail
        smtp = Net::SMTP.new config["server"], config["port"]
        smtp.enable_starttls

        smtp.start(config["domain"], config["user"], config["password"], :login) do
          smtp.send_message(message, config["user"], config["receivers"])
        end
      end

      def config
        @config ||= parse_config
      end

      def parse_config
        YAML.load_file(config_file)
      end

      def message
        "Subject: #{subject}\n\n#{subject}\n\n#{changelog}"
      end

      def subject
        "Changelog - deployment #{Time.now.strftime("%d/%m/%Y %k:%M")}"
      end
  end
end
