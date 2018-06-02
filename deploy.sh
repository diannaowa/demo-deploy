#!/bin/bash

set -e

COM=$1
NAMESPACE=$2
TAG=$3
SVC_PORT=$4

function load_template {

  data=$(cat $1.json)
  data_for=$(echo $data | sed 's/\"/\\\"/g')
  eval echo $data_for > tmp/$1.json

  return 0
}

load_template $COM
load_template ${COM}-svc

kubectl --server $K8S_MASTER_HOST apply -f tmp/$COM.json
kubectl --server $K8S_MASTER_HOST apply -f tmp/${COM}-svc.json
rm -rf tmp/*.json
