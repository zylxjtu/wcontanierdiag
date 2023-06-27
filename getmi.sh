#!/bin/bash

# This shell script demonstrate how to get the predefine MI 
# This will give you another chance to get the MI info if you have somehow missed them in the addmitocluster.sh
#

source env.sh

# Need to login first
#az login
az account set --subscription $subscription

# First to check if the USMI has been assigned or not

command_output=$(az vmss identity show -g "MC_${resourcegroup}_${clustername}_${location}" -n "aks$nodepoolname" |grep  $managedidentityresourceid)

if [ -n "$command_output" ]; then 
  # Need to note down the tenantid and objectid (principal id) and let us know
  # so we can grant access to the MDS logging
  echo "***********************************************************************************************************"
  echo "Note down the tenanatId and principalId and let muse know, we will need them to grant access to MDS logging"
  echo "***********************************************************************************************************"
  az identity show --ids $managedidentityresourceid
else
  echo "MI has not been assigned, need to run addmitocluster.sh to create and assign the MI"
fi
