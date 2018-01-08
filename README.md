# Vagrant SparkBWA Sandbox

Vagrant project to spin up a single virtual machine running:

 * Hadoop 2.7.2
 * Spark 2.2.0
 * OpenJDK 1.8
 * Maven

The virtual machine will be running the following services:

 * HDFS NameNode + NameNode
 * YARN ResourceManager + JobHistoryServer + ProxyServer
 * Spark history server

## Getting Started

 1. Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
 2. Download and install[Vagrant](http://www.vagrantup.com/downloads.html).
 3. Clone this repo ```git clone https://github.com/adriannovegil/sparkbwa-sandbox```
 4. In your terminal change your directory into the project directory (i.e. `cd sparkbwa-sandbox`).
 5. Run ```vagrant up``` to create the VM.
 6. Execute ```vagrant ssh``` to login to the VM.

## Web User Interfaces

Here are some useful links to navigate to various UI's:

__Hadoop__

 * YARN resource manager:  (http://10.211.55.101:8088)
 * Job history:  (http://10.211.55.101:19888/jobhistory/)
 * HDFS: (http://10.211.55.101:50070/dfshealth.html)

__Spark__

 * Spark history server: (http://10.211.55.101:18080)
 * Spark context UI (if a Spark context is running): (http://10.211.55.101:4040)

## Starting Services in the Event of a System Restart

Currently if you restart your VM then the Hadoop/Spark services won't be
up (this is something I'll address soon).  In the interim you can run the
following commands to bring them up:

```
$ vagrant ssh
$ sudo -s
$ sh /vagrant/scripts/start-hadoop.sh
$ sh /usr/local/spark/sbin/start-history-server.sh
```

## Validating your Virtual Machine Setup

After the ```vagrant up``` command has completed, you'll have a CentOS
virtual machine with the following installed:

 * Hadoop HDFS
 * Hadoop YARN
 * Spark

Let's take a look at each one and validate that it's installed and
setup as expected.

SSH into your virtual machine.

```
$ vagrant ssh
```

### Validating HDFS

Run an example MapReduce job. Then create a directory for the input file

```
$ hdfs dfs -mkdir -p wordcount-input
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
 * dear   1
 * hello  2
 * world  1

```
$ hdfs dfs -cat wordcount-output/part*
```

### Validating Spark

Next launch the interactive Spark shell.

```
$ spark-shell --master yarn
```

Run word count in Spark.

```
// enter paste mode
:paste
sc.textFile("hdfs:///user/vagrant/wordcount-input/hello.txt")
   .flatMap(line => line.split(" "))
   .map(word => (word, 1))
   .reduceByKey(_ + _)
   .collect.foreach(println)

<ctrl-D>

sc.stop
```

## Credits

This project is based on the great work carried out at
(https://github.com/alexholmes/vagrant-hadoop-spark-hive).

## License

This project is licensed under the terms of the [GNU General Public License](./LICENSE), versión 2
