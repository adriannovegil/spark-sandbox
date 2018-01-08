#!/bin/bash

set -o errexit

echo "Provisioning BDE"

# Get and uncompress the software.
wget http://bdev.des.udc.es/releases/bdev-3.0.tar.gz
tar -xvzf bdev-3.0.tar.gz

# Create the directory scratch
sudo mkdir /scratch
sudo chmod -R 777 /scratch/

# Copy the configuration folder
rm -Rf bdev-3.0/experiment
cp -R /vagrant/files/bdev/experiment ./bdev-3.0/

# Get the framework to the test.


echo "BDE Successfully Provisioned"
