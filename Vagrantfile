Vagrant.require_version ">= 1.4.3"
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    i = 1
    config.vm.define "node#{i}" do |node|
        node.vm.box = "bento/centos-7.2"
        node.vm.provider "virtualbox" do |v|
          v.name = "sparkbwa-sandbox"
          v.customize ["modifyvm", :id, "--memory", "32768"]
          v.customize ["modifyvm", :id, "--cpus", "8"]
        end
        node.vm.network :private_network, ip: "10.211.55.101"
        node.vm.hostname = "10.211.55.101"

        # Workaround for Centos 7
        # service network restart
        # service NetworkManager restart
        node.vm.provision "shell",
          inline: "service network restart",
          run: "always"
        node.vm.provision "shell",
          inline: "service NetworkManager restart",
          run: "always"

        # Base
        node.vm.provision "shell", path: "provision/setup-centos.sh"
        node.vm.provision "shell", path: "provision/setup-java.sh"
        node.vm.provision "shell", path: "provision/setup-maven.sh"

        # Hadoop, HDFS, Spark, etc.
        node.vm.provision "shell", path: "provision/setup-hadoop.sh"
        node.vm.provision "shell", path: "provision/setup-spark.sh"

        # Finish provision
        node.vm.provision "shell", path: "provision/finalize-centos.sh"
    end
end
