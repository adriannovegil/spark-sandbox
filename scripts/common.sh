#!/bin/bash

# Curl options
CURL_OPTS="-Ss --retry 10 "

# java
JAVA_ARCHIVE=jdk-8u51-linux-x64.gz
JAVA_MYSQL_CONNECTOR_VERSION=5.1.40
JAVA_MYSQL_CONNECTOR_JAR=mysql-connector-java-${JAVA_MYSQL_CONNECTOR_VERSION}.jar
JAVA_MYSQL_CONNECTOR_DOWNLOAD=http://central.maven.org/maven2/mysql/mysql-connector-java/${JAVA_MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${JAVA_MYSQL_CONNECTOR_VERSION}.jar

# hadoop
HADOOP_PREFIX=/usr/local/hadoop
HADOOP_CONF=$HADOOP_PREFIX/etc/hadoop
HADOOP_VERSION=hadoop-2.7.3
HADOOP_ARCHIVE=$HADOOP_VERSION.tar.gz
HADOOP_MIRROR_DOWNLOAD=http://archive.apache.org/dist/hadoop/core/$HADOOP_VERSION/$HADOOP_ARCHIVE
HADOOP_RES_DIR=/vagrant/resources/hadoop

# Yarn
HADOOP_YARN_HOME=$HADOOP_PREFIX

# hive
HIVE_VERSION=1.2.2
HIVE_ARCHIVE=apache-hive-${HIVE_VERSION}-bin.tar.gz
HIVE_MIRROR_DOWNLOAD=http://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/$HIVE_ARCHIVE
HIVE_RES_DIR=/vagrant/resources/hive
HIVE_CONF=/usr/local/hive/conf
HIVE_PREFIX=/usr/local/hive
HIVE_EXEC_JAR=${HIVE_PREFIX}/lib/hive-exec-${HIVE_VERSION}.jar

# spark
SPARK_VERSION=spark-2.1.1
SPARK_ARCHIVE=$SPARK_VERSION-bin-hadoop2.tgz
SPARK_MIRROR_DOWNLOAD=http://archive.apache.org/dist/spark/$SPARK_VERSION/$SPARK_VERSION-bin-hadoop2.7.tgz
SPARK_RES_DIR=/vagrant/resources/spark
SPARK_CONF_DIR=/usr/local/spark/conf

# ssh
SSH_RES_DIR=/vagrant/resources/ssh
RES_SSH_COPYID_ORIGINAL=$SSH_RES_DIR/ssh-copy-id.original
RES_SSH_COPYID_MODIFIED=$SSH_RES_DIR/ssh-copy-id.modified
RES_SSH_CONFIG=$SSH_RES_DIR/config

# vim
VIM_RES_DIR=/vagrant/resources/vim

# root password for mysql
MYSQL_ROOT_PASSWORD=root

# sqoop 
SQOOP_RELEASE=sqoop-1.4.6.bin__hadoop-2.0.4-alpha
SQOOP_ARCHIVE=${SQOOP_RELEASE}.tar.gz
SQOOP_MIRROR_DOWNLOAD=http://mirror.ox.ac.uk/sites/rsync.apache.org/sqoop/1.4.6/${SQOOP_ARCHIVE}
SQOOP_RES_DIR=/vagrant/resources/sqoop

# Tez
TEZ_VERSION=0.8.5
TEZ_RELEASE=apache-tez-${TEZ_VERSION}-bin
TEZ_ARCHIVE=${TEZ_RELEASE}.tar.gz
TEZ_MIRROR_DOWNLOAD=http://mirror.catn.com/pub/apache/tez/${TEZ_VERSION}/${TEZ_ARCHIVE}
TEZ_RES_DIR=/vagrant/resources/tez

# Pig
PIG_VERSION=0.17.0
PIG_RELEASE=pig-${PIG_VERSION}
PIG_ARCHIVE=${PIG_RELEASE}.tar.gz
PIG_MIRROR_DOWNLOAD=http://apache.mirror.anlx.net/pig/pig-${PIG_VERSION}/${PIG_ARCHIVE}
PIG_RES_DIR=/vagrant/resources/pig

# flume
FLUME_VERSION=1.7.0
FLUME_RELEASE=apache-flume-${FLUME_VERSION}-bin
FLUME_ARCHIVE=${FLUME_RELEASE}.tar.gz
FLUME_MIRROR_DOWNLOAD=http://www.mirrorservice.org/sites/ftp.apache.org/flume/${FLUME_VERSION}/${FLUME_ARCHIVE}
#FLUME_MIRROR_DOWNLOAD=http://apache.mirror.anlx.net/flume/${FLUME_VERSION}/${FLUME_ARCHIVE}
FLUME_RES_DIR=/vagrant/resources/flume

# Zeppelin 
ZEPPELIN_VERSION=0.7.2
ZEPPELIN_RELEASE=zeppelin-${ZEPPELIN_VERSION}-bin-netinst
ZEPPELIN_ARCHIVE=${ZEPPELIN_RELEASE}.tgz
ZEPPELIN_MIRROR_DOWNLOAD=http://www-eu.apache.org/dist/zeppelin/zeppelin-${ZEPPELIN_VERSION}/${ZEPPELIN_ARCHIVE}
ZEPPELIN_RES_DIR=/vagrant/resources/zeppelin
ZEPPELIN_TARGET=/home/ubuntu


# Utility functions
function resourceExists {
	FILE=/vagrant/resources/$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}

function fileExists {
	FILE=$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}
