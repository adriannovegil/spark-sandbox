#!/bin/bash

set -o errexit

echo "Configuring the SSH Service"

#ssh-keygen -f ~/.ssh/id_rsa -t rsa -b 4096 -C $(whoami)@$(hostname) -N ''
#cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
#chmod og-wx ~/.ssh/authorized_keys

# Copy the keys
cp /vagrant/files/keys/id_rsa  ~/.ssh/id_rsa
cp /vagrant/files/keys/id_rsa.pub  ~/.ssh/id_rsa.pub
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# Change permissions
chown -R vagrant:vagrant ~/.ssh/*
chmod 400 ~/.ssh/id_rsa
chmod og-wx ~/.ssh/authorized_keys

echo "SSH Service Successfully Configured"
