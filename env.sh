#!/bin/bash

# This is to export environment variables that will be shared by a couple of shell scripts
# Every cluster specific configuration should be set/update here before running the scripts

export subscription="Replace with your value"
export subscriptonid="Replace with your value"
export resourcegroup="Replace with your value"
export clustername="Replace with your value"
# windows agent pool name can not be longer than 6 characters
export nodepoolname="Replace with your value"
export location="Replace with your value"

export managedidentity="Replace with your value"

export managedidentityresourceid="/subscriptions/$subscriptonid/resourcegroups/containerTest/providers/Microsoft.ManagedIdentity/userAssignedIdentities/$managedidentity"

# Do not need to care about the lines below if you are not creating new clusters
export nodevmsize="Replace with your value"
export WINDOWS_USERNAME="Replace with your value"
export WINDOWS_PASSWORD="Replace with your value"
