#!/bin/bash

set -o errexit

echo "Provisioning Java 8"

# Get the installer
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.rpm"

# Install the package
sudo rpm -ivh jdk-8u131-linux-x64.rpm

# Set the JAVA_HOME
sudo sh -c "echo export JAVA_HOME=/usr/java/jdk1.8.0_131/jre >> /etc/environment"

echo "Java 8 Successfully Provisioned"

echo "Provisioning Maven"

# Get the package
wget http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz

# Unzip the package
sudo mkdir /opt/maven
sudo tar -zxvf apache-maven-3.3.9-bin.tar.gz -C /opt/maven --strip-components=1

# Set the environment variables
sudo sh -c "echo export M2_HOME=/opt/maven >> /etc/environment"
sudo sh -c "echo export PATH=/opt/maven/bin:${PATH} >> /etc/environment"

echo "Maven Successfully Provisioned"
