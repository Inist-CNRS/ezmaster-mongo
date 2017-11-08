#!/bin/bash

# inject config.json parameters to env
# only if not already defined in env
export DUMP_EACH_NBHOURS=${DUMP_EACH_NBHOURS:=$(jq -r -M .DUMP_EACH_NBHOURS /config.json | grep -v null)}
export DUMP_CLEANUP_MORE_THAN_NBDAYS=${DUMP_CLEANUP_MORE_THAN_NBDAYS:=$(jq -r -M .DUMP_CLEANUP_MORE_THAN_NBDAYS /config.json | grep -v null)}


# backup/dump stuff
dump.periodically.sh &

# start postgresql
exec /usr/local/bin/docker-entrypoint.sh $@