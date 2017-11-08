#!/bin/bash
# script looping indefinitly and doing each X hours
# a mongodump into /data/dump folder

while true
do
  # loop until the database is ready to accept query
  echo -n "Waiting until mongodb is ready to run mongodump."
  ret=1
  while [ $ret -gt 0 ]
  do
    echo -n "."
    sleep 1
    # todo
    #echo "SELECT datname FROM pg_database"  | psql -v ON_ERROR_STOP=1 --username $POSTGRES_USER --dbname $POSTGRES_DB 2>/dev/null 1>/dev/null
    ret=$?
  done

  DUMP_FILE=/data/dump.$(date '+%Y-%m-%d_%Hh%M').archive
  echo "Running dump through pg_dump: $DUMP_FILE"
  #TODO
  #pg_dump --username=$POSTGRES_USER $POSTGRES_DB > $DUMP_FILE
  
  echo "Cleaning old dump."
  tmpreaper --verbose ${DUMP_CLEANUP_MORE_THAN_NBDAYS}d /data/dump

  echo "Waiting $PGDUMP_EACH_NBHOURS hours before next dump."
  sleep ${DUMP_EACH_NBHOURS}h
done
