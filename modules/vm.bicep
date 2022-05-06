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

var name = 'vm-${location}-${id}'

resource vm 'Microsoft.Compute/virtualMachines@2021-11-01' = {
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

//output publicIp string = ip.properties.ipAddress
