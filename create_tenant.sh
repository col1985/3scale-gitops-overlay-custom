#!/usr/bin/env bash

set -e

if [ -z "$1" ]
  then
    echo "No Cluster value has been passed."
    exit 1
fi

if [ -z "$2" ]
  then
    echo "No target Environment value has been passed."
    echo "Please pass a value of development | testing | production"
    exit 1
fi

CLUSTER=$1
ENV=$2

TENANT_PATH="3scale/tenants/tenant-${ENV}.yaml"

update_tenant_config () {
  echo "${CLUSTER}"
  sed 's/apps.*eu/${CLUSTER}/g' $TENANT_PATH > temp.yml && \
  mv temp.yml $TENANT_PATH
}

apply_tenant_config () {
  oc apply -f $TENANT_PATH
}

init () {
  printf "Updating tenant config for cluster: %s \n\nTarget Env: %s" $CLUSTER $ENV
  update_tenant_config
  apply_tenant_config

  printf "Tenant config has been updated: %s \n" $TENANT_PATH
  echo
  echo "************************************"
  cat $TENANT_PATH
  echo "\n************************************"
}

init