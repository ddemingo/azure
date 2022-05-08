#!/bin/bash

case $1 in
    login)
        az login --tenant ddemingolamerce.onmicrosoft.com
        az configure --defaults group='test'
    ;;
    login-sandbox)
        az login --tenant learn.docs.microsoft.com
        az configure --defaults group=`az group list --query '[].name' --output tsv`
    ;;
    deploy)
        # https://docs.microsoft.com/en-us/cli/azure/deployment/group?view=azure-cli-latest
        az deployment group create --template-file $2
    ;;
    group-create)
        az group create --location francecentral --name test  
    ;;
    group-delete)
        az group delete --location francecentral --name test
    ;;
    *)
        echo "unkown command"
    ;;
    #az bicep decompile --file azuredeploy.json

esac

# https://docs.microsoft.com/es-es/learn/modules/improve-app-scalability-resiliency-with-load-balancer/4-exercise-configure-public-load-balancer?pivots=bash
# 2 horas: vm, vnet

