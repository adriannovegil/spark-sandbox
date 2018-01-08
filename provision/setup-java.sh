#!/bin/bash

#
# Install Java
#
source "/vagrant/provision/common.sh"

function installJava {
	echo "install open jdk"
	yum install -y java-1.8.0-*
}

function setupJava {
	echo "setting up java"
	ln -s /usr/lib/jvm/java-1.8.0 /usr/local/java
}

function setupEnvVars {
	echo "creating java environment variables"
	ENVIRONMENT_FILE="/etc/profile.d/java.sh"
	echo export JAVA_HOME=/usr/local/java >> $ENVIRONMENT_FILE
	echo export PATH=\${JAVA_HOME}/bin:\${PATH} >> $ENVIRONMENT_FILE
}

echo "setup java"

installJava
setupJava
setupEnvVars

echo "Java setup complete"
