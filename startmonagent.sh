hostprocesspod=hpc
# Need to login first
#az login
#az account set --subscription $subscription

# Retrieve the credentials of existing cluster
#az aks get-credentials --resource-group $resourcegroup --name $clustername --overwrite-existing

# Fill the deployment yaml file with correct parameters
sed -i -e "s,<managedidentityresourceid>,${managedidentityresourceid}," \
       -e "s/<subscription>/${subscription}/" \
       -e "s/<resourcegroup>/${resourcegroup}/" \
       -e "s/<clustername>/${clustername}/" \
       -e 's/\r//g' \
       ./${hostprocesspod}.yaml

# Deploy the monagent hpc container and start the monagnet process
kubectl apply -f ./${hostprocesspod}.yaml --wait

kubectl wait --for=condition=Ready --all --timeout -1s pods

kubectl get pods -o wide
