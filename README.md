# README

## Bicep

```sh
az bicep install && az bicep upgrade
az login
az configure --defaults group=`az group list --query '[].name' --output tsv`

az deployment group create --template-file global-vm.bicep

az deployment group list -o table
```


```sh
az configure --defaults group=`az group list --query '[].name' --output tsv`

az account list-locations -o table
az vm list-ip-addresses -o table

ssh -o StrictHostKeyChecking=no azure@...


```

