#!/bin/bash

set -o errexit

echo "Provisioning the NFS Client"

# Install the packages
sudo yum install -y nfs-utils libnfsidmap

# Then enable and start the nfs server service.
sudo systemctl enable rpcbind
sudo systemctl start rpcbind

# Create and mount the folders
mkdir ~/bdev-3.0
sudo mount 10.0.9.20:/home/vagrant/bdev-3.0 ~/bdev-3.0

mkdir ~/BDEv_OUT
sudo mount 10.0.9.20:/home/vagrant/BDEv_OUT ~/BDEv_OUT

# Make the mount point permanent
sudo sh -c "echo 10.0.9.20:/home/vagrant/bdev-3.0 /home/vagrant/bdev-3.0 nfs rw,sync,hard,intr 0 0 >> /etc/fstab"
sudo sh -c "echo 10.0.9.20:/home/vagrant/BDEv_OUT /home/vagrant/bdev-3.0 nfs rw,sync,hard,intr 0 0 >> /etc/fstab"

echo "NFS Client Successfully Provisioned"
