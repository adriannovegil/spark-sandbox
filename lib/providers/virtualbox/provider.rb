# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative "utils/network.rb"

module Template
  module Providers
    module Virtualbox
      class VirtualboxProvider

        #
        # Function that provision the servers using Virtualbox
        # Params:
        # +machine_instance+::
        # +server_config+::
        #
        def self.configVirtualBox(machine_instance, server_config)

          # Provide the Virtual Maniche
          # More Info See: http://docs.vagrantup.com/v2/vagrantfile/machine_settings.html
          machine_instance.vm.provider :virtualbox do |vb|
            vb.name = server_config['guest-hostname']
            vb.cpus = server_config['cpus'] || 2
            vb.memory = server_config['memory'] || 2048

            # SSH settings
            if server_config["ssh-pub-key"]
              machine_instance.ssh.insert_key = false
              machine_instance.vm.provision "file", source: server_config["ssh-pub-key"], destination: "~/.ssh/authorized_keys"
              machine_instance.ssh.private_key_path = [server_config["ssh-prv-key"], "~/.vagrant.d/insecure_private_key"]
            end

            # Configure the instance group
            if server_config["group"]
              vb.customize ["modifyvm", :id, "--groups", "/" + server_config["group"]]
            end

            # Activate Nat Host Resolver
            vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

            # http://stackoverflow.com/questions/19490652/how-to-sync-time-on-host-wake-up-within-virtualbox
            vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000 ]
            vb.gui = false
          end

          # Configure the hostname
          machine_instance.vm.hostname = server_config['guest-hostname']

          # Network configuration
          Template::Providers::Virtualbox::Utils::NetworkManager.configureNetwork(machine_instance, server_config)

          # custom hostname aliases
          if server_config['aliases']
            machine_instance.hostmanager.aliases = server_config['aliases'].join(' ').to_s
          end

          # Set box type based on configuration. Defaults to `precise64` (Ubuntu).
          if !server_config["box"]
            machine_instance.vm.box = "ubuntu/trusty64"
          else
            machine_instance.vm.box = server_config["box"]
          end

          # Set the box URL
          # The URL that you see below is from Vagrant's own list of available boxes:
          # http://www.vagrantbox.es/
          if server_config["box-url"]
            machine_instance.vm.box_url = server_config["box-url"]
          end

          # Provisioning the server
          if server_config.has_key?("scripts")
            # Execute the provisioning servers
            server_config["scripts"].each do |script, key|
              serverScript = "./provisioning/" + script
              machine_instance.vm.provision "shell",
                path: serverScript,
                privileged: false
            end

            # Run the oc-cluster-wrapper script
#            if ARGV[0] == "up"
#               puts("[info] Run the oc-cluster up command")
#               serverScript = "./provisioning/run-oc-cluster.sh"
#               machine_instance.vm.provision "shell",
#                path: serverScript,
#                privileged: false
#            end
          end
        end
      end
    end
  end
end
