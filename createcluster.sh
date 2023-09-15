#!/bin/bash

# This shell script demonstrates how to create an Azure AKS cluster, plus a windows node
#

source env.sh

# Need to login first
#az login
az account set --subscription $subscription

# create resource group if it does not exist
# comment it out if you already have the RG created
az group create --name $resourcegroup --location $location

# delete cluster if it exists
#az aks delete --name $clustername --resource-group $resourcegroup --yes 

echo "Started to create AKS cluster"
az aks create \
    --resource-group $resourcegroup \
    --name  $clustername \
    --node-count 2 \
    --enable-addons monitoring \
    --generate-ssh-keys \
    --windows-admin-username $WINDOWS_USERNAME \
    --windows-admin-password $WINDOWS_PASSWORD \
    --vm-set-type VirtualMachineScaleSets \
    --network-plugin azure \
    --enable-managed-identity \
    --assign-identity  $managedidentityresourceid\
    --assign-kubelet-identity $managedidentityresourceid

echo "Started to add windows node pool"
# containerrd will be the default runtime if we do not set it
az aks nodepool add \
    --resource-group $resourcegroup \
    --cluster-name $clustername \
    --os-type Windows \
    --os-sku Windows2022 \
    --name $nodepoolname \
    --aks-custom-headers WindowsContainerRuntime=containerd \
    --node-vm-size $nodevmsize \
    --node-count 1

echo "Retrieve the newly created cluster credentials"
az aks get-credentials --resource-group $resourcegroup --name $clustername --overwrite-existing
