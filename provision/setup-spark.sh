#!/bin/bash

# http://www.cloudera.com/content/cloudera/en/documentation/core/v5-2-x/topics/cdh_ig_spark_configure.html

source "/vagrant/provision/common.sh"

function installSpark {
	echo "install spark from remote file"
	curl -sS -o /vagrant/resources/$SPARK_ARCHIVE -O -L $SPARK_MIRROR_DOWNLOAD
	tar -xzf /vagrant/resources/$SPARK_ARCHIVE -C /usr/local

	ln -s /usr/local/$SPARK_VERSION-bin-hadoop2.7 /usr/local/spark
	mkdir -p /usr/local/spark/logs/history
}

function setupSpark {
	echo "setup spark"
	cp -f /vagrant/resources/spark/slaves /usr/local/spark/conf
	cp -f /vagrant/resources/spark/spark-env.sh /usr/local/spark/conf
	cp -f /vagrant/resources/spark/spark-defaults.conf /usr/local/spark/conf
}

function setupEnvVars {
	echo "creating spark environment variables"
	cp -f $SPARK_RES_DIR/spark.sh /etc/profile.d/spark.sh
	. /etc/profile.d/spark.sh
}

function setupHistoryServer {
	echo "setup history server"
	. /etc/profile.d/hadoop.sh
  #hdfs dfs -mkdir -p /user/spark/applicationHistory
  #hdfs dfs -chmod -R 777 /user/spark

	hdfs dfs -mkdir /user/spark
	hdfs dfs -mkdir -p /user/spark/applicationHistory
	hdfs dfs -chown -R spark:spark /user/spark
	hdfs dfs -chmod 1777 /user/spark/applicationHistory

}

function startServices {
	echo "starting Spark history service"
	/usr/local/spark/sbin/start-history-server.sh
}

echo "setup spark"

installSpark
setupSpark
setupEnvVars
setupHistoryServer
startServices

echo "spark setup complete"
