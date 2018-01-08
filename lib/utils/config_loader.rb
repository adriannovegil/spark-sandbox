# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'json'

module Template
  module Utils
    class ConfigLoader

      #
      # Load the server configuration from the configuration file.
      #
      def self.loadConfig()

        config = {}
        config["servers"] = {}

        # Check if the config file exists
        if File.exists?(File.expand_path "./config.json")
          # Load the preference file
          config = JSON.parse(File.read(File.expand_path "./config.json"))
        else
          raise "Config file not found"
        end

        # Trying to fill the mandatory parameters if it is not present..
        if config.has_key?("servers")
          if config["servers"].count >= 1
            config["servers"].each do |key, server|
              if !server.has_key?("provider")
                server["provider"] = "virtualbox"
              end
              if !server.has_key?("enabled")
                server["enabled"] = true
              end
              if !server.has_key?("autostart")
                server["autostart"] = true
              end
              if !server.has_key?("paths")
                server["paths"] = {}
              end
              if !server.has_key?("aliases")
                server["aliases"] = []
              end
              if !server.has_key?("timezone")
                server["timezone"] = "Europe/Madrid"
              end
              if !server.has_key?("cpus")
                server["cpus"] = 1
              end
              if !server.has_key?("memory")
                server["memory"] = 2048
              end
            end
          else
            raise "No servers defined in the config file."
          end
        else
          raise "No {servers} block found in the config file."
        end

        ENV["VAGRANT_DEFAULT_PROVIDER"] = config["provider"]

        return config
      end

    end
  end
end
