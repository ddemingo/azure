@secure()
param password string

var location = 'francecentral'

module vnet 'shared/vnet.bicep' = {
  name: 'france-vnet'
  params: {
    location: location
    netId: 1
    numberOfSubnets: 2
  }
}

module vm 'shared/vm.bicep' = {
  name: 'france-vm'
  params: {
    location: location
    id: 1
    adminPassword: password
    subnetId: vnet.outputs.subnets[1].id
  }
}

output vnetId string = vnet.outputs.vnetId
