#!/bin/bash
# https://docs.vagrantup.com/v2/provisioning/shell.html

source "/vagrant/provision/common.sh"

function disableFirewall {
	echo "disabling firewall"
	systemctl disable firewalld
	systemctl stop iptables
	systemctl disable iptables
	systemctl mask iptables
}

function setupHosts {
	echo "modifying /etc/hosts file"
#    entry="10.211.55.101 node1"
#    echo "adding ${entry}"
#    echo "${entry}" >> /etc/nhosts
	echo "127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4" >> /etc/nhosts
	echo "::1         localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /etc/nhosts
	echo "10.211.55.101   master.hadoop.lan " >> /etc/nhosts
	#cat /etc/hosts >> /etc/nhosts
	cp /etc/nhosts /etc/hosts
	rm -f /etc/nhosts
}

function installSSHPass {
	yum -y install sshpass
}

function overwriteSSHCopyId {
	cp -f $RES_SSH_COPYID_MODIFIED /usr/bin/ssh-copy-id
}

function createSSHKey {
	echo "generating ssh key"
	ssh-keygen -t rsa -P "" -f ~/.ssh/id_rsa
	cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
	cp -f $RES_SSH_CONFIG ~/.ssh
}

function setupUtilities {
		# Update the SO
		yum -y update --exclude=*kernel*
    # so the `locate` command works
    yum install -y mlocate
    updatedb
		yum install -y nano wget git
		yum groupinstall -y 'Development Tools'
		yum install -y zlib-devel.i686
		sudo ln -s ../../lib64/libz.so.1.2.7 /usr/lib64/libz.so
}

echo "setup centos"
disableFirewall

echo "setup centos hosts file"
setupHosts

echo "setup ssh"
installSSHPass
createSSHKey
overwriteSSHCopyId

echo "setup utilities"
setupUtilities

echo "centos setup complete"
