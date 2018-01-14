# SparkPremer Sandbox

## Introduction

Vagrant project to spin up a single virtual machine running to test the SparkPremer algorithm:

Sandbox configuration:

* Hadoop 2.7.3
* Hive 1.2.2
* Spark 2.1.1
* mysql 5.7 (for hive metastore)
* Tez 0.8.5
* Sqoop 1.4.6
* Pig 0.17.0
* flume 1.7.0
* Zeppelin 0.7.2 (with Spark/scala, md, file and JDBC interpreters)

The virtual machine will be running the following services:

* HDFS NameNode + DataNode
* YARN ResourceManager/NodeManager + JobHistoryServer + ProxyServer
* Hive metastore and server2
* Spark history server
* MySQL
* Zeppelin notebook server (not started by default)

Hadoop and friends are all installed under ```/usr/local```.

### Versions

File [scripts/common.sh](scripts/common.sh) can be edited if you want to
change the version of a particular system.

## Getting Started

1. [Download and install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Download and install Vagrant](http://www.vagrantup.com/downloads.html).
3. Go to [releases](https://github.com/martinprobson/vagrant-hadoop-hive-spark/releases) and download and extract the latest source of this project.
5. In your terminal change your directory into the project directory.
6. Run ```vagrant up``` to create the VM (**NOTE** *This will take a while the first time as many dependancies are downloaded - subsequent deployments will be quicker as dependancies are cached in the `resources` directory*).
7. Execute ```vagrant ssh``` to login to the VM.

## Validating the installation

After the ```vagrant up``` command has completed, you'll have a Ubuntu virtual machine with the following installed:

* Hadoop HDFS
* Hadoop YARN
* Hive
* Spark
* Hive on Tez

Let's take a look at each one and validate that it's installed and setup as expected.

Run an example MapReduce job.

Create a directory for the input file

```
$ hdfs dfs -mkdir wordcount-input
```

Generate sample input and write it to HDFS

```
$ echo "hello dear world hello" | hdfs dfs -put - wordcount-input/hello.txt
```
Run the MapReduce word count example

```
$ hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop*example*.jar \
  wordcount wordcount-input wordcount-output
```

Validate the output of the job - you should see the following in the output:

```
# dear   1
# hello  2
# world  1

$ hdfs dfs -cat wordcount-output/part*
```

Now, launch the Hive shell.

```
$ hive
```

Create a table and run a query over it.

```
CREATE EXTERNAL TABLE wordcount (
    word STRING,
    count INT
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LOCATION '/user/ubuntu/wordcount-output';

select * from wordcount order by count;
```

To run the same query using Tez: -

```
set hive.execution.engine=tez;
```

Next launch the interactive Spark shell.

```
$ spark-shell --master yarn-client
```

Run word count in Spark.

```
// enter paste mode
:paste
sc.textFile("hdfs:///user/ubuntu/wordcount-input/hello.txt")
   .flatMap(line => line.split(" "))
   .map(word => (word, 1))
   .reduceByKey(_ + _)
   .collect.foreach(println)

<ctrl-D>

sc.stop
```

## Map Reduce - Tez

By default map reduce jobs will be executed via Tez to change this to standard MR, change the following parameter in $HADOOP_CONF/mapred-site.xml from: -

```xml
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn-tez</value>
    </property>
```

to

```xml
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
```

## Web user interfaces

Here are some useful links to navigate to various UI's:

* YARN resource manager:  (http://10.211.55.101:8088)
* Job history:  (http://10.211.55.101:19888/jobhistory/)
* HDFS: (http://10.211.55.101:50070/dfshealth.html)
* Spark history server: (http://10.211.55.101:18080)
* Spark context UI (if a Spark context is running): (http://10.211.55.101:4040)
* Zeppelin notebook (if notebook server is started) (http://10.211.55.101:8080)

## Mysql

mysql database connection

* `root@10.211.55.101:3306` (for root DBA access - password is 'root')
* `hive@10.211.55.101:3306` (for hive metastore user - password is 'hive')

## Validating your virtual machine setup

To test out the virtual machine setup, and for examples of how to run
MapReduce, Hive and Spark, head on over to [VALIDATING.md](VALIDATING.md).

## Managment of Vagrant VM

To stop the VM and preserve all setup/data within the VM: -

```
$ vagrant halt
```
or

```
$ vagrant suspend
```

Issue a `vagrant up` command again to restart the VM from where you left off.

To completely **wipe** the VM so that `vagrant up` command gives you a fresh machine: -

```
$ vagrant destroy
```

Then issue `vagrant up` command as usual.

### To shutdown services cleanly

```
$ vagrant ssh
$ sudo -sE
$ /vagrant/scripts/stop-spark.sh
$ /vagrant/scripts/stop-hadoop.sh
$ systemctl stop mysql.service
```
