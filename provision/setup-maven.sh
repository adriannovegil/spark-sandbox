#!/bin/bash

#
# Install Maven
#
source "/vagrant/provision/common.sh"

function installMaven {
  echo "install Maven from remote file"
  MAVEN_VERSION=3.3.9
  wget http://mirror.olnevhost.net/pub/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz
  tar -xvzf apache-maven-$MAVEN_VERSION-bin.tar.gz
  sudo mv apache-maven-$MAVEN_VERSION /usr/local/apache-maven
}

function setupEnvVars {
  echo "creating maven environment variables"
  #~/.bashrc
  ENVIRONMENT_FILE="/etc/profile.d/maven.sh"
  echo export M2_HOME=/usr/local/apache-maven >> $ENVIRONMENT_FILE
  echo export M2=\${M2_HOME}/bin >> $ENVIRONMENT_FILE
  echo export M2_REPO=\${M2_HOME}/repo >> $ENVIRONMENT_FILE
  echo export PATH=\${PATH}:\${M2} >> $ENVIRONMENT_FILE
}

echo "setup maven"

installMaven
setupEnvVars

echo "Maven setup complete"
