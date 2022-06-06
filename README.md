# README

## Python

```sh
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

```sh
pip install --user -r requirements.txt
```

```sh
 export AZURE_SUBSCRIPTION_ID=
```

- [Example: Use the Azure libraries to provision a virtual machine](https://docs.microsoft.com/en-us/azure/developer/python/azure-sdk-example-virtual-machines?tabs=cmd)

https://markwarneke.me/2021-03-14-Query-Azure-Resources-Using-Python/

## CLI

```sh
az deployment group list -o table
az account list-locations -o table
az vm list-ip-addresses -o table

ssh -o StrictHostKeyChecking=no azure@


```

azure-quickstart-templates/application-workloads

https://github.com/dmauser/azure-gateway-lb

