#!/bin/bash

# This shell script demonstrates how to start monagnet on custoerm's cluster inside a hpc pod
#

source env.sh

hostprocesspod=hpc
# Need to login first
#az login
az account set --subscription $subscription

# Retrieve the credentials of existing cluster
#az aks get-credentials --resource-group $resourcegroup --name $clustername --overwrite-existing

# Deploy the monagent hpc container and start the monagnet process
az aks update -n ${clustername} -g $resourcegroup --attach-acr $registryname

sed -e "s,\$managedidentityresourceid,$managedidentityresourceid," \
    -e "s/\$subscription/$subscription/" \
    -e "s/\$resourcegroup/$resourcegroup/" \
    -e "s/\$clustername/$clustername/" \
    -e 's/\r//g' \
    ./${hostprocesspod}.yaml.template > ${hostprocesspod}.yaml

kubectl apply -f ./${hostprocesspod}.yaml --wait

kubectl wait --for=condition=Ready --all --timeout -1s pods

kubectl get pods -o wide
