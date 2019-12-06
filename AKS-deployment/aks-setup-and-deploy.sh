#!/bin/bash
. aks_info.sh
. credentials.sh

# Install necessary commands for Azure and Kubernetes (run as root):
# curl -sL https://aka.ms/InstallAzureCLIDeb | bash
# az aks install-cli
# az login

# Create a service principal account to create the Kubernetes cluster (only has to be done once, left here only for future reference):
# az ad sp create-for-rbac

if [ ! -f "credentials.sh" ]; then
    echo "No credentials.sh file with principal account credentials and docker secret, you have to create it manually"
    exit 1;
fi

# Create resource group
az group create --name $GROUP_NAME --location $WORLD_REGION

# Create Azure Container Registry with admin enabled
az acr create --resource-group $GROUP_NAME --name $AZURE_CONTAINER_REGISTRY --sku Basic --admin-enabled true

# Login to the Azure Container Registry (ACR).
az acr login --name $AZURE_CONTAINER_REGISTRY

# Obtain the ACR's login server name.
LOGIN_SERVER=`az acr show --name $AZURE_CONTAINER_REGISTRY --query loginServer --output tsv`

# Create Kubernetes cluster with the principal account (need to have manually included the principal_credentials.sh file)
az aks create --resource-group "$GROUP_NAME" --name "$KUB_CLUSTER_NAME" --node-count 2 --service-principal "$SERVICE_PRINCIPAL_ID" --client-secret "$SERVICE_PRINCIPAL_PASSWORD" --node-vm-size Standard_B2s -l $WORLD_REGION --generate-ssh-keys --kubernetes-version 1.13.12

# Login to AKS cluster to configure kubectl to connect to the cluster
az aks get-credentials --resource-group $GROUP_NAME --name $KUB_CLUSTER_NAME

# Create ACR secret to connect AKS with ACR
kubectl create secret docker-registry $DOCKER_SECRET --docker-server $AZURE_CONTAINER_REGISTRY.azurecr.io --docker-username $SERVICE_PRINCIPAL_ID --docker-password $SERVICE_PRINCIPAL_PASSWORD --docker-email $MAIL

# Build the Kubernetes containers
docker build ../AzureFunctionsApp -t $LOGIN_SERVER/azurefunctionsapp:latest
docker build ../NodeApp -t $LOGIN_SERVER/nodeapp:latest

# Push the containers to Kubernetes
docker push $LOGIN_SERVER/azurefunctionsapp:latest
docker push $LOGIN_SERVER/nodeapp:latest

# Deploy application
cat "kubernetes.yaml" | sed "s/{{ACR}}/$AZURE_CONTAINER_REGISTRY/g" | kubectl apply -f -

# Monitor progress and obtain EXTERNAL-IP once it is ready
watch kubectl get service nodeapp