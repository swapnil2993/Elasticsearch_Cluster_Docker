#!/bin/bash

# Fail immediately if anything goes wrong and return the value of the last command to fail/run
set -eo pipefail

# Set environment
ES_CLUSTER_NAME=${ES_CLUSTER_NAME:-"es_cluster"}
ES_CFG_FILE="/opt/elasticsearch-1.7.2/config/elasticsearch.yml"

# Reset/set to value to avoid errors in env processing
ES_CFG_URL=${ES_CFG_FILE}

# Process environment variables
for VAR in `env`; do
  if [[ "$VAR" =~ ^ES_ && ! "$VAR" =~ ^ES_CFG_ && ! "$VAR" =~ ^ES_HOME && ! "$VAR" =~ ^ES_VERSION && ! "$VAR" =~ ^ES_VOL && ! "$VAR" =~ ^ES_USER && ! "$VAR" =~ ^ES_GROUP ]]; then
    ES_CONFIG_VAR=$(echo "$VAR" | sed -r "s/ES_(.*)=.*/\1/g" | tr '[:upper:]' '[:lower:]' | tr _ . | sed  -r "s/\.\./_/g")
    ES_ENV_VAR=$(echo "$VAR" | sed -r "s/(.*)=.*/\1/g")

    if egrep -q "(^|^#)$ES_CONFIG_VAR" $ES_CFG_FILE; then
      # No config values may contain an '@' char. Below is due to bug otherwise seen.
      sed -r -i "s@(^|^#)($ES_CONFIG_VAR): (.*)@\2: ${!ES_ENV_VAR}@g" $ES_CFG_FILE
    else
      echo "$ES_CONFIG_VAR: ${!ES_ENV_VAR}" >> $ES_CFG_FILE
    fi
  fi
done

# if `docker run` first argument start with `--` the user is passing launcher arguments
if [[ "$1" == "-"* || -z $1 ]]; then
  /opt/elasticsearch-1.7.2/bin/elasticsearch --config=${ES_CFG_FILE} "$@"
else
  exec "$@"
fi
