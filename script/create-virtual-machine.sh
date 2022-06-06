#!/bin/bash

echo "Login to learn.docs.microsoft.com tenant"
az login --tenant learn.docs.microsoft.com

export group=`az group list --query '[].name' --output tsv`

export username="azure"
export location="francecentral"

echo "Creating a new virtual machine"
az vm create \
    --name us \
    --resource-group $group \
    --location francecentral \
    --image UbuntuLTS \
    --admin-username $username \
    --generate-ssh-keys \
    --public-ip-sku Standard

echo "open port 80 on vm"
az vm open-port --resource-group $group --name $name --port 80

az vm list-ip-addresses -o table
echo "ssh -o StrictHostKeyChecking=no azure@ip"


# Install docker
# sudo apt update
# sudo apt install docker.io
# sudo systemctl enable --now docker
# sudo docker run -d -p 80:80 mcr.microsoft.com/azuredocs/aci-helloworld
