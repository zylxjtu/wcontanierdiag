#!/bin/bash

# This shell script demonstrates how to clean up the MDS logging related setting/resource 
#
display_usage()
{
    echo "This script will delete the hpc pod, remove the MI assignment to the aks cluster pool, and delete the MI which is controlled by the true/false option, by default, the MI WILL BE DELETED"
    echo -e "\nUsage: $0 [true/false]\n"
}

# check whether user had supplied -h or --help . If yes display usage 
if [[ ( $@ == "--help") ||  $@ == "-h" ]] 
then 
    display_usage
    exit 0
fi

#if more than one argument supplied, display usage
if [ $# != 1 ]
then
    display_usage
    exit 1
fi

delete_mi=${1:-true}

if [ "$delete_mi" != "true" ] && [ "$delete_mi" != "false" ]; then
  echo "The option is neither 'true' nor 'false', you will need to set it up correctly."
  exit 2
fi

source env.sh

# The name is defined in the hpc.yaml file 
hostprocesspod=hpc

# Need to login first
#az login
#az account set --subscription $subscription

# Retrieve the credentials of existing cluster
#az aks get-credentials --resource-group $resourcegroup --name $clustername --overwrite-existing

# Delete the hpc pods
command_output=$(kubectl get pods -o wide)

if [ -n "$command_output" ]; then
  echo "Delete the hpc pods"
  kubectl delete pods $hostprocesspod
else
  echo "hpc pods has been deleted"
fi

# Remove the MI from the AKS cluser node pool
# Then to check if the USMI has been assigned or not
command_output=$(az vmss identity show -g "MC_${resourcegroup}_${clustername}_${location}" -n "aks$nodepoolname" |grep  $managedidentityresourceid)

if [ -n "$command_output" ]; then
  echo "Start to remove the assignment of the MI to the aks node npool."
  # Remove the assignment of  MI to the aks node pool
    az vmss identity remove -g "MC_${resourcegroup}_${clustername}_${location}" -n "aks$nodepoolname" --identities $managedidentityresourceid
else
  echo "MI $managedidentityresourceid has been removed from the aks cluster node pool ${clustername}."
fi

# Delete the managed identity
echo "Start to check the existence of MI"
command_output=$(az identity show --ids $managedidentityresourceid 2>/dev/null)

if [ -z "$command_output" ]; then
  echo "The MI does not exist any more"
else
  if [ "$delete_mi" = "true" ]; then
    az identity delete --ids $managedidentityresourceid
    echo "MI ${managedidentityresourceid} deleted"
  else
    echo "The option of this script is to Keep the MI"
  fi
fi
