#!/bin/bash

set -o errexit

echo "Provisioning the Server"

# Config DNS
sudo cp /vagrant/files/config/resolv.conf /etc/resolv.conf

# Disable security
# Disable Firewalld In CentOS 7
sudo systemctl stop firewalld
sudo systemctl disable firewalld
# Disable Iptables In CentOS 7
sudo systemctl stop iptables
sudo systemctl disable iptables
# Disable Selinux
sudo sed -i 's@SELINUX=enforcing@SELINUX=disabled@g' /etc/sysconfig/selinux
sudo sed -i 's@SELINUX=permissive@SELINUX=disabled@g' /etc/sysconfig/selinux
sudo sed -i 's@SELINUX=enforcing@SELINUX=disabled@g' /etc/selinux/config
sudo sed -i 's@SELINUX=permissive@SELINUX=disabled@g' /etc/selinux/config
sudo setenforce 0
sudo getenforce

# Install software base
sudo yum -y install nano wget curl zip bzip2 rpm-build psmisc mvapich2 papi oprofile gnuplot expect bc

# Install Git
sudo yum -y install git
git config --global user.name "Vagrant Machine"
git config --global user.email "vagrant-machine@domain.com"

# Configure git. Disable SSL Check
sudo cat << EOF | sudo tee /etc/gitconfig
[http]
  sslVerify = false
EOF

echo "Server Successfully Provisioned"
