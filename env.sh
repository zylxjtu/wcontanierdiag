#!/bin/bash

# This is to export environment variables that will be shared by a couple of shell scripts
# Every cluster specific configuration should be set/update here before running the scripts

#export subscription="WAMS-TEST-StreamingTeam"
#export subscriptonid="1b447bc0-050f-4d85-b2b8-d79a631e9750"
export subscription="yuanliang"
export subscriptonid="b922e3c4-f2ae-4867-9699-16b6158acebf"
export resourcegroup="containerTest"
export clustername="wincontainertest"
export nodepoolname="npwin"
export location="westus"
export nodevmsize="Standard_D2s_v3"
export managedidentity="containerTestMI"

export managedidentityresourceid="/subscriptions/$subscriptonid/resourcegroups/containerTest/providers/Microsoft.ManagedIdentity/userAssignedIdentities/$managedidentity"

# Do not need to care about the lines below if you are not creating new clusters
# Replace the password with the actual one when you deploy
export WINDOWS_USERNAME="containertest"

# Replace the password with the real one
export WINDOWS_PASSWORD="Abcd123456789@"
