#!/bin/bash

case $1 in 
    login)
        az login --tenant learn.docs.microsoft.com
        az configure --defaults group=`az group list --query '[].name' --output tsv`
    ;;
    deploy)
        az deployment group create --template-file $2
    ;;
    deploy-complete)
        az deployment group create --template-file $2 --mode Complete
    ;;
esac

# https://docs.microsoft.com/es-es/learn/modules/improve-app-scalability-resiliency-with-load-balancer/4-exercise-configure-public-load-balancer?pivots=bash
# 2 horas: vm, vnet

