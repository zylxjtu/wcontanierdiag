#!/bin/bash

source env.sh
hostprocesspod=hpc
# Need to login first
#az login
#az account set --subscription $subscription

# This can be removed after we pushed the HPC image to a public repository
az aks update -n ${clustername} -g $resourcegroup --attach-acr $registryname

# Retrieve the credentials of existing cluster
#az aks get-credentials --resource-group $resourcegroup --name $clustername --overwrite-existing

# Deploy the monagent hpc container and start the monagnet process
kubectl apply -f ./${hostprocesspod}.yaml --wait

kubectl wait --for=condition=Ready --all --timeout -1s pods

kubectl get pods -o wide

kubectl exec -it ${hostprocesspod} -- powershell ./startMonagent.ps1 $managedidentityresourceid $subscription $resourcegroup $clustername 1.20
