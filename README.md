# README

[Google Docs](https://drive.google.com/drive/folders/1g4Ld5eXxiU_4r19CNQPBDXHIUm2tEZtD?usp=sharing)

## Python

Install required python libraries.

With virtual environment:

```sh
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```


Global home install:

```sh
pip install --user -r requirements.txt
```


- [Example: Use the Azure libraries to provision a virtual machine](https://docs.microsoft.com/en-us/azure/developer/python/azure-sdk-example-virtual-machines?tabs=cmd)


## CLI

```sh
az deployment group list -o table
az account list-locations -o table
az vm list-ip-addresses -o table

ssh -o StrictHostKeyChecking=no azure@


```


