#!/bin/bash

# https://hadoop.apache.org/docs/r2.4.1/hadoop-yarn/hadoop-yarn-common/yarn-default.xml

source "/vagrant/provision/common.sh"

function installHadoop {
	echo "install hadoop from remote file"
	curl -sS -o /vagrant/resources/$HADOOP_ARCHIVE -O -L $HADOOP_MIRROR_DOWNLOAD
	tar -xzf /vagrant/resources/$HADOOP_ARCHIVE -C /usr/local

	ln -s /usr/local/$HADOOP_VERSION /usr/local/hadoop
}

function setupHadoop {
	echo "creating hadoop directories"
	mkdir /var/hadoop
	mkdir /var/hadoop/hadoop-datanode
	mkdir /var/hadoop/hadoop-namenode
	mkdir /var/hadoop/mr-history
	mkdir /var/hadoop/mr-history/done
	mkdir /var/hadoop/mr-history/tmp

	echo "copying over hadoop configuration files"
	cp -f $HADOOP_RES_DIR/* $HADOOP_CONF
}

function setupEnvVars {
	echo "creating hadoop environment variables"
	cp -f $HADOOP_RES_DIR/hadoop.sh /etc/profile.d/hadoop.sh
	. /etc/profile.d/hadoop.sh
}

function formatHdfs {
    echo "formatting HDFS"
    hdfs namenode -format
}

function startDaemons {
    echo "starting daemon"
    sh /vagrant/scripts/start-hadoop.sh
}

function setupHdfs {
    echo "creating user home directory in hdfs"
    hdfs dfs -mkdir -p /user/root
    hdfs dfs -mkdir -p /user/vagrant
    hdfs dfs -chown vagrant /user/vagrant

    echo "creating temp directories in hdfs"
    hdfs dfs -mkdir -p /tmp
    hdfs dfs -chmod -R 777 /tmp

    hdfs dfs -mkdir -p /var
    hdfs dfs -chmod -R 777 /var
}

echo "setup hadoop"

installHadoop
setupHadoop
setupEnvVars
formatHdfs
startDaemons
setupHdfs

echo "hadoop setup complete"
