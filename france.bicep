@secure()
param password string

var location = 'francecentral'

module vnet 'modules/vnet.bicep' = {
  name: 'france-vnet'
  params: {
    location: location
    secondIpByte: 1
    numberOfSubnets: 2
  }
}

module vm 'modules/vm.bicep' = {
  name: 'france-vm'
  params: {
    location: location
    id: 1
    adminPassword: password
    subnetId: vnet.outputs.subnets[1].id
  }
}

output vnetId string = vnet.outputs.vnetId
