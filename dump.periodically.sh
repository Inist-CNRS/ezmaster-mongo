#!/bin/bash
# script looping indefinitly and doing each X hours
# a mongodump into /data/dump folder

while true
do
  # loop until the database is ready to accept connections
  echo -n "Waiting until mongodb is ready to run mongodump."
  until nc -z 127.0.0.1 27017
  do
    echo -n "."
    sleep 1
  done  

  DUMP_FILE=/data/dump/dump.$(date '+%Y-%m-%d_%Hh%M').archive
  echo "Creating a dump with mongodump in $DUMP_FILE"
  mongodump --quiet --archive=- > $DUMP_FILE
  
  echo "Cleaning old dump."
  tmpreaper --verbose ${DUMP_CLEANUP_MORE_THAN_NBDAYS}d /data/dump/

  echo "Waiting $PGDUMP_EACH_NBHOURS hours before next dump."
  sleep ${DUMP_EACH_NBHOURS}h
done
