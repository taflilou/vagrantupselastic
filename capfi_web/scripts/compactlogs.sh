#!/bin/bash
# Decompress CAPFI Apache log files tarball and 
# create a file for each virtualhost log files:  
# access + error => sql | beta | 6st | 1j1h1a | wiki
# wiki | blog | ftp | capfi

TARBALL_LOGS_FILE="../source/capfilogs.tar"
DEST_LOG_DIR="../dest/"

# Create a .bak copy first
cp -f $TARBALL_LOGS_FILE $TARBALL_LOGS_FILE'.bak'

# Decompress CAPFI logs
TMP_DEST_DIR="../source/tmp"
mkdir -p $TMP_DEST_DIR
tar -xvf $TARBALL_LOGS_FILE -C $TMP_DEST_DIR

# Create 6st access log path
STACCESS_LOGNAME="6st_access.log"
STACCESS_LOGPATH="$DEST_LOG_DIR$STACCESS_LOGNAME"
echo "" > $STACCESS_LOGPATH
# Decompress .gz files if any
ls ../source/tmp/*6st*access* | xargs gunzip && rm -rf ../source/tmp/*6st*access*gz
# Create 6st access log file
ls ../source/tmp/*6st*access* | grep -v *.gz | xargs sort -k 4,4 >> $STACCESS_LOGPATH



#  
# # Create 6st error log file
# 6ST_ERROR_LOGFILE=$DEST_LOG_DIR'6st_error.log'
# ls *6st*error* |  xargs sort -k 4,4 >> $6ST_ERROR_LOGFILE