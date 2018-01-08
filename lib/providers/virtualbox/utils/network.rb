# encoding: ascii-8bit

require 'resolv'

module Template
  module Providers
    module Virtualbox
      module Utils
        class NetworkManager

          #
          # Function that configure the network interfaces
          # Params:
          # +machine_instance+::
          # +server_config+::
          #
          def self.configureNetwork(machine_instance, server_config)
            if server_config.has_key?("network")
              network_config = server_config["network"]
              # Configure interfaces
              if network_config.has_key?("interfaces")
                interfaces_config = network_config["interfaces"]
                # Iterate over the network interfaces
                interfaces_config.each do |interface|
                  type = interface['network-type']
                  # We only handle private and public networks
                  next if type != "private" && type != "public"
                  # Configure it
                  if type == "public"
                    configureInterface("public_network", machine_instance, interface)
                  elsif type == "private"
                    configureInterface("private_network", machine_instance, interface)
                  end
                end
              end
              # Workaround for Centos 7
              # service network restart
              # service NetworkManager restart
              machine_instance.vm.provision "shell",
                inline: "service network restart",
                run: "always"
              machine_instance.vm.provision "shell",
                inline: "service NetworkManager restart",
                run: "always"
              # Configure the gateway
              if network_config.has_key?("gw-ip")
                configureGateway(machine_instance, network_config)
              end
              # Set Ip Forward to True
              setIpForwardTrue(machine_instance)
            end
          end

          #
          # Configure the gateway
          # Params:
          # +machine_instance+::
          # +network_config+::
          #
          private
          def self.configureGateway(machine_instance, network_config)
            # Get the gateway ip
            gwip = network_config["gw-ip"]
            # Remove all the default route gw
            machine_instance.vm.provision "shell",
              inline: "ip route flush 0/0",
              run: "always"
            # Add the default route gw
#            machine_instance.vm.provision "shell",
#              inline: "ip route add default via " + gwip,
#              run: "always"
            # Compose ip route command
            command = ["ip"]
            case gwip
            when Resolv::IPv6::Regex
              command += ["-6"]
            end
            command += ["route", "add", "default", "via", gwip]
            # Get and set the gw interface
            if network_config.has_key?("gw-if")
              command += ["dev", network_config["gw-if"]]
            end
            # Execute command
            machine_instance.vm.provision "shell",
              inline: command.join(" "),
              run: "always"
          end

          #
          # Configure a interface
          # Params:
          # +type+::
          # +machine_instance+::
          # +network_config+::
          #
          private
          def self.configureInterface(type, machine_instance, interface)
            # Parameters map
            parameters = {}
            if interface.has_key?("bridge-adapter")
              parameters[:bridge] = interface['bridge-adapter']
            end
            if interface.has_key?("if-inet-type")
              if interface["if-inet-type"] == "dhcp"
                parameters[:type] = interface['if-inet-type']
                # Configure interface
                machine_instance.vm.network type, parameters
                return
              end
            end
            if interface.has_key?("if-address")
              parameters[:ip] = interface['if-address']
              if interface.has_key?("if-netmask")
                parameters[:netmask] = interface['if-netmask']
              end
            else
              parameters[:type] = "dhcp"
            end
            # Configure interface
            machine_instance.vm.network type, parameters
          end

          #
          # Set Ip Forward to True
          # Params:
          # +machine_instance+::
          #
          private
          def self.setIpForwardTrue(machine_instance)
            # Configure ip forward in the system
            machine_instance.vm.provision "shell",
              inline: "sysctl -w net.ipv4.ip_forward=1",
              run: "always"
          end

        end
      end
    end
  end
end
