#!/usr/bin/env python3

from azure.identity import AzureCliCredential
from azure.mgmt.resource import ResourceManagementClient
from azure.mgmt.network import NetworkManagementClient
from azure.mgmt.compute import ComputeManagementClient
import os

LOCATION = "francecentral"

credential = AzureCliCredential()
subscription_id = os.environ["AZURE_SUBSCRIPTION_ID"]

print(f"Subscription:\t{subscription_id}")


# Resource Group

resource_client = ResourceManagementClient(credential, subscription_id)
group_list = resource_client.resource_groups.list()
group_name = group_list.next().name

print(f"Resource Group:\t{group_name}")


# Virtual Network (provision)

VNET_NAME = "asix"
SUBNET_NAME = "asix-subnet"
IP_NAME = "asix-ip"
IP_CONFIG_NAME = "asix-ip-config"


network_client = NetworkManagementClient(credential, subscription_id)

poller = network_client.virtual_networks.begin_create_or_update(group_name, VNET_NAME,
    {
        "location": LOCATION,
        "address_space": {
            "address_prefixes": ["10.0.0.0/16"]
        }
    }
)
vnet_result = poller.result()
print(f"Network:\t {vnet_result.address_space.address_prefixes ({vnet_result.name})}")

poller = network_client.subnets.begin_create_or_update(group_name, 
    VNET_NAME, SUBNET_NAME,
    { "address_prefix": "10.0.0.0/24" }
)
subnet_result = poller.result()

print(f"Network Subnet:\t {subnet_result.address_prefix} ({subnet_result.name})")

# IP Address (provision)

poller = network_client.public_ip_addresses.begin_create_or_update(group_name,
    IP_NAME,
    {
        "location": LOCATION,
        "sku": { "name": "Standard" },
        "public_ip_allocation_method": "Static",
        "public_ip_address_version" : "IPV4"
    }
)

ip_address_result = poller.result()

print(f"IP address:\t {ip_address_result.ip_address} ({ip_address_result.name})")

# NIC: Network Interface Client (provision)

NIC_NAME = "asix-nic"

poller = network_client.network_interfaces.begin_create_or_update(group_name, NIC_NAME, 
    {
        "location": LOCATION,
        "ip_configurations": [ {
            "name": IP_CONFIG_NAME,
            "subnet": { "id": subnet_result.id },
            "public_ip_address": {"id": ip_address_result.id }
        }]
    }
)
nic_result = poller.result()

print(f"NIC:\t {nic_result.name}")


# Virtual Machine (provision)

VM_NAME = "us1"
USERNAME = "azure"
PASSWORD = "ChangePa$$w0rd24"

compute_client = ComputeManagementClient(credential, subscription_id)
poller = compute_client.virtual_machines.begin_create_or_update(group_name, VM_NAME,
    {
        "location": LOCATION,
        "storage_profile": {
            "image_reference": {
                "publisher": 'Canonical',
                "offer": "UbuntuServer",
                "sku": "16.04.0-LTS",
                "version": "latest"
            }
        },
        "hardware_profile": {
            "vm_size": "Standard_DS1_v2"
        },
        "os_profile": {
            "computer_name": VM_NAME,
            "admin_username": USERNAME,
            "admin_password": PASSWORD
        },
        "network_profile": {
            "network_interfaces": [{
                "id": nic_result.id,
            }]
        }        
    }
)

vm_result = poller.result()

print(f"Virtual Machine:\t {vm_result.name}")
print(f"ssh -o StrictHostKeyChecking=no {USERNAME}@{ip_address_result.ip_address}")
