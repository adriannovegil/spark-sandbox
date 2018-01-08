#!/bin/sh
# 
# ## Configuration parameters regarding BDEv behaviour
# 
# export ENABLE_PLOT="true"	# Enable plot generation
# export ENABLE_STAT="false"	# Enable resource stats generation
# export ENABLE_ILO="false"	# Enable HP-iLO power measurements
# export ENABLE_RAPL="false"	# Enable RAPL power measurements
# export ENABLE_OPROFILE="false"	# Enable Oprofile event counting
# export DEFAULT_TIMEOUT="28800"	# Default workload timeout
# export OUT_DIR=$PWD/${METHOD_NAME}_OUT	# Default report output directory
# 
# # Resource stats
# export STAT_GEN_GRAPHS="false"	# Generate graphs during execution
# export STAT_SECONDS_INTERVAL=5	# Interval (seconds) for each sample
# export STAT_WAIT_SECONDS=20	# Waiting time (seconds) before each benchmark execution
# 
# # HP-iLO
# export ILO_SECONDS_INTERVAL=5		# Interval (seconds) for each sample
# export ILO_WAIT_SECONDS=60              # Waiting time (seconds) before each benchmark execution
# export ILO_USERNAME="ilo_user"          # User name for ILO interface
# export ILO_PASSWD="..ilo_user.."        # Password for ILO user
# export ILO_BASE_IP="192.168.255"	# Base IP for ILO interfaces
# export ILO_MASTER="localhost"           # Node which can connect to the ILO interface for all the slaves (localhost means to use the master node)
# 
# # RAPL
# export RAPL_GEN_GRAPHS="false"	# Generate RAPL graphs during execution
# export RAPL_SECONDS_INTERVAL=5	# Interval (seconds) for each sample
# export RAPL_WAIT_SECONDS=60		# Waiting time (seconds) before each benchmark execution
# export PAPI_HOME=$THIRD_PARTY_DIR/papi-5.5.1/src	# PAPI home directory
# 
# # OPROFILE
# export OPROFILE_GEN_GRAPHS="false" # Generate Oprofile graphs during execution
# export OPROFILE_BIN_DIR=$(dirname `which ocount`)	# Directory containing OProfile binaries
# export OPROFILE_EVENTS="INST_RETIRED,LLC_MISSES,LLC_REFS" # Events to record during OProfile analysis (can be consulted by using the ophelp command)
# export OPROFILE_WAIT_SECONDS=20	# Waiting time (seconds) before each benchmark execution
# 
