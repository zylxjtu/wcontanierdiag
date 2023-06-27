#!/bin/bash

# This shell script demonstrate creating an user assign MI to and assigned it to an existing AKS node pool 
#

source env.sh

# Need to login first
#az login
az account set --subscription $subscription

# First to create the MI if it has not been created yet
command_output=$(az identity show --ids $managedidentityresourceid 2>/dev/null)

if [ -z "$command_output" ]; then
  echo "Started to create MI"
  az identity create --name $managedidentity --resource-group $resourcegroup
else
  echo "MI has already been created"
fi

# Then to check if the USMI has been assigned or not
command_output=$(az vmss identity show -g "MC_${resourcegroup}_${clustername}_${location}" -n "aks$nodepoolname" |grep  $managedidentityresourceid)

if [ -z "$command_output" ]; then
  echo "Start to assign the MI to the aks node pool."
  # Assign the predefined user assigned MI to the aks node pool
    az vmss identity assign -g "MC_${resourcegroup}_${clustername}_${location}" -n "aks$nodepoolname" --identities $managedidentityresourceid

else
  echo "MI has been assigned to the aks node pool."
fi

echo "**********************************************************************************************************"
echo "Note down the tenanatId and principalId and let muse know, we will need them to grant access to MDS logging"
echo "***********************************************************************************************************"
az identity show --ids $managedidentityresourceid


