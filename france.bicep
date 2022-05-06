@secure()
param password string

var location = 'francecentral'

module vnet 'modules/vnet.bicep' = {
  name: 'vnet'
  params: {
    location: location
    id: 1
    subnets: [
      0
      1
    ]
  }
}

module vm 'modules/vm.bicep' = {
  name: 'vm'
  params: {
    location: location
    id: 1
    adminPassword: password
    subnetId: vnet.outputs.subnets[1].id
  }
}

output vnetId string = vnet.outputs.vnetId
