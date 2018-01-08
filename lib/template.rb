# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative "providers/virtualbox/provider.rb"

require_relative "utils/config_loader.rb"
require_relative "utils/required_plugins.rb"
require_relative "utils/validate_server_config.rb"

module Template
  class TemplateManager

    #
    # Check if all the Vagrant plugins are installed
    #
    def hasPlugin()
      return Template::Utils::PluginManager.hasPlugin()
    end

    #
    # Load the server configuration from the configuration file.
    #
    def loadConfig()
      return Template::Utils::ConfigLoader.loadConfig
    end

    #
    # Function that validate the machine config
    # Params:
    # +config+:: Instances configuration
    #
    def validateServerConfig(config)
      return Template::Utils::ValidationManager.validateServerConfig(config)
    end

    #
    # Function that provision the servers using Virtualbox
    # Params:
    # +machine_instance+::
    # +server_config+::
    #
    def configVirtualBox(machine_instance, server_config)
      return Template::Providers::Virtualbox::VirtualboxProvider.configVirtualBox(machine_instance, server_config)
    end

  end
end
