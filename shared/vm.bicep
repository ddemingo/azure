@description('The location of you Virtual Machine.')
param location string

@description('The name of you Virtual Machine.')
param id int

param subnetId string

@description('Username for the virtual machine.')
param adminUsername string = 'azure'

@description('Password for the virtual machine.')
@minLength(12)
@secure()
param adminPassword string

param publicIpAddressId string = ''

param script string = ''

var name = 'vm-${location}-${id}'

resource virtualMachine 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: name
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2s'
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: '18.04-LTS'
        version: 'latest'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
    osProfile: {
      computerName: name
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
  }
}

// https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-05-01/networkinterfaces?tabs=bicep
resource nic 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: 'nic-${location}-${id}'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetId
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: ip.id
          }
          loadBalancerBackendAddressPools: []
        }
      }
    ]
  }
}

resource ip 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: 'ip-${location}-${id}'
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    publicIPAddressVersion: 'IPv4'
  }
}

// https://docs.microsoft.com/en-us/azure/templates/microsoft.compute/virtualmachines/runcommands?tabs=bicep
resource vmExtension 'Microsoft.Compute/virtualMachines/runCommands@2021-11-01' = if (script != '') {
  parent: virtualMachine
  name: '${name}-run-command'
  location: location
  properties: {
    source: {
      script: script
    }
  }
}

//output publicIp string = ip.properties.ipAddress
