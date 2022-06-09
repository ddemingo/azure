#!/usr/bin/env python3

from azure.identity import AzureCliCredential
from azure.mgmt.resource import ResourceManagementClient
from azure.mgmt.network import NetworkManagementClient
from azure.mgmt.compute import ComputeManagementClient
import subprocess

subscription_id = subprocess.check_output("az account show --query id --output tsv", shell=True, text=True)
subscription_id = subscription_id.strip()
print(f"Subscription:\t'{subscription_id}'")

credential = AzureCliCredential()

# Resource Group

resource_client = ResourceManagementClient(credential, subscription_id)
group_list = resource_client.resource_groups.list()
group_name = group_list.next().name

print(f"Resource Group:\t{group_name}")


