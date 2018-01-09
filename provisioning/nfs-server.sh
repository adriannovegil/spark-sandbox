#!/bin/bash

set -o errexit

echo "Provisioning the NFS Server"

# Install the packages
sudo yum install -y nfs-utils libnfsidmap

# Then enable and start the nfs server service.
sudo systemctl enable nfs-server.service
sudo systemctl enable rpcbind

sudo systemctl start rpcbind
sudo systemctl start nfs-server
sudo systemctl start rpc-statd
sudo systemctl start nfs-idmapd

# Share the folder
sudo sh -c "echo /home/vagrant/bdev-3.0 10.0.9.0/24\(rw,sync,no_root_squash\) >> /etc/exports"

# Expor the mount point
sudo exportfs -r

echo "NFS Server Successfully Provisioned"
