#!/bin/bash

set -o errexit

echo "Provisioning the Server"

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
