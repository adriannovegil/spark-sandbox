#!/bin/sh

## Configuration parameters of the different frameworks

#FLAME-MR
export FLAMEMR_HADOOP_HOME=${SOLUTIONS_DIST_DIR}/Hadoop-YARN/2.7.4
export FLAMEMR_WORKERS_PER_NODE=1 # Number of workers per node
export FLAMEMR_CORES_PER_WORKER=`op_int "$CORES_PER_NODE / $FLAMEMR_WORKERS_PER_NODE"`	# Number of cores per ẁorker
export FLAMEMR_WORKER_HEAPSIZE_FACTOR=0.90	# Percentage of the executor memory allocated to heap
export FLAMEMR_WORKER_HEAPSIZE=`op_int "($CONTAINER_MEMORY * $FLAMEMR_CORES_PER_WORKER) * $FLAMEMR_WORKER_HEAPSIZE_FACTOR"`	# Executor heapsize
export FLAMEMR_DEBUG_MODE="false"
export FLAMEMR_ITERATIVE_MODE="false"
export FLAMEMR_ADDITIONAL_CONFIGURATION=""


# RDMA-Hadoop/RDMA-Hadoop-2
export RDMA_HADOOP_IB_ENABLED="true"	# Enable RDMA connections through InfiniBand (IB)
export RDMA_HADOOP_ROCE_ENABLED="false" # Enable RDMA connections through RDMA over Converged Ethernet (RoCE)
export RDMA_HADOOP_DFS_REPLICATION_PARALLEL="false"	# Enable parallel replication
export RDMA_HADOOP_DFS_SSD_USED="false"	# Enable SSD-oriented optimizations for HDFS
export RDMA_HADOOP_DISK_SHUFFLE_ENABLED="true"	# Enable disk-based shuffle

# Spark (common)
export SPARK_HADOOP_HOME=${SOLUTIONS_DIST_DIR}/Hadoop-YARN/2.7.4
export SPARK_DRIVER_HEAPSIZE=$MASTER_HEAPSIZE	# Driver heapsize
export SPARK_DRIVER_CORES=1	# Number of cores of the driver
export SPARK_EXECUTORS_PER_NODE=1	# Number of executors (workers) per node
export SPARK_CORES_PER_EXECUTOR=$CORES_PER_NODE	# Number of cores per executor
export SPARK_LOCAL_DIRS=$LOCAL_DIRS # Executor temporary directories
export SPARK_HISTORY_SERVER="false"     # Start the Spark HistoryServer
export SPARK_HISTORY_SERVER_DIR=spark/history # HDFS realtive path to store application event logs

# Spark standalone
export SPARK_EXECUTOR_HEAPSIZE_FACTOR=0.90	# Percentage of the executor memory allocated to heap
export SPARK_EXECUTOR_HEAPSIZE=`op_int "($CONTAINER_MEMORY * $SPARK_CORES_PER_EXECUTOR) * $SPARK_EXECUTOR_HEAPSIZE_FACTOR"`	# Executor heapsize

# Spark on YARN (client mode)
export SPARK_AM_HEAPSIZE=$APP_MASTER_HEAPSIZE	# Application Master heapsize
export SPARK_YARN_EXECUTOR_MEMORY=`op_int "($CONTAINER_MEMORY * $SPARK_CORES_PER_EXECUTOR)"`	# Amount of memory allocated to the executor in YARN
export SPARK_YARN_EXECUTOR_HEAPSIZE_FACTOR=0.90	# Percentage of the executor memory allocated to heap in YARN
export SPARK_YARN_EXECUTOR_HEAPSIZE=`op_int "$SPARK_YARN_EXECUTOR_MEMORY * $SPARK_YARN_EXECUTOR_HEAPSIZE_FACTOR"` # Executor heapsize in YARN

# RDMA-Spark
export RDMA_SPARK_IB_ENABLED="true"	# Enable RDMA connections through InfiniBand (IB)
export RDMA_SPARK_ROCE_ENABLED="false"	# Enable RDMA connections through RDMA over Converged Ethernet (RoCE)
export RDMA_SPARK_SHUFFLE_CHUNK_SIZE=524288	# Chunk size for shuffle

# Flink (common)
export FLINK_HADOOP_HOME=${SOLUTIONS_DIST_DIR}/Hadoop-YARN/2.7.4
export FLINK_TASKMANAGER_SLOTS=$CORES_PER_NODE	# Number of slots per TaskManager
export FLINK_TASKMANAGERS_PER_NODE=1	# Number of TaskManagers per node
export FLINK_TASKMANAGER_TMP_DIRS=$LOCAL_DIRS	# TaskManager temporary directories
export FLINK_TASKMANAGER_NETWORK_BUFFERS_FACTOR=8	# Factor that multiplies the number of network buffers per slave
export FLINK_TASKMANAGER_NETWORK_BUFFERS_PER_SLAVE=`op_int "($FLINK_TASKMANAGER_SLOTS ^ 2) * $FLINK_TASKMANAGER_NETWORK_BUFFERS_FACTOR"` # Network buffers per slave
export FLINK_TASKMANAGER_PREALLOCATE_MEMORY="false" # TaskManager preallocate memory

# Flink standalone
export FLINK_JOBMANAGER_HEAPSIZE=$MASTER_HEAPSIZE	# JobManager heapsize
export FLINK_TASKMANAGER_HEAPSIZE_FACTOR=0.90	# Percentage of the TaskManager memory allocated to heap
export FLINK_TASKMANAGER_HEAPSIZE=`op_int "($CONTAINER_MEMORY * $FLINK_TASKMANAGER_SLOTS) * $FLINK_TASKMANAGER_HEAPSIZE_FACTOR"` # TaskManager heapsize

# Flink on YARN
export FLINK_YARN_JOBMANAGER_MEMORY=1536	# JobManager memory in YARN
export FLINK_YARN_TASKMANAGER_MEMORY=`op_int "($CONTAINER_MEMORY * $FLINK_TASKMANAGER_SLOTS) - $FLINK_YARN_JOBMANAGER_MEMORY"`	# TaskManager memory in YARN

# DataMPI
export DATAMPI_HADOOP_HOME=${SOLUTIONS_DIST_DIR}/Hadoop/1.2.1
export DATAMPI_TASK_HEAPSIZE_FACTOR=0.90	# Percentage of the task memory allocated to heap
export DATAMPI_TASK_HEAPSIZE=`op_int "$CONTAINER_MEMORY * $DATAMPI_TASK_HEAPSIZE_FACTOR"` # Task heapsize

# Mellanox UDA library
export UDA_VERSION=3.3.2	# UDA library version
export UDA_LIB_DIR=$SOLUTIONS_LIB_DIR/uda-$UDA_VERSION	# UDA library directory

# Apache Mahout
export MAHOUT_HEAPSIZE=$MASTER_HEAPSIZE	# Heap size for Mahout master process
export HADOOP_1_MAHOUT_VERSION=0.11.2	# Mahout version for Hadoop 1
export HADOOP_2_MAHOUT_VERSION=0.11.2	# Mahout version for Hadoop 2 (YARN)

# Apache Hive
export HADOOP_1_HIVE_VERSION=1.2.1	# Hive version for Hadoop 1
export HADOOP_2_HIVE_VERSION=1.2.1	# Hive version for Hadoop 2 (YARN)
export HIVE_TMP_DIR=/hive/tmp		# HDFS directory to store temporary files

