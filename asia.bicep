@secure()
param password string

var location = 'eastasia'

module vnet 'shared/vnet.bicep' = {
  name: 'asia-vnet'
  params: {
    location: location
    secondIpByte: 2
    numberOfSubnets: 2
  }
}

module vm 'shared/vm.bicep' = {
  name: 'asia-vm'
  params: {
    location: location
    id: 1
    adminPassword: password
    subnetId: vnet.outputs.subnets[1].id
  }
}

output vnetId string = vnet.outputs.vnetId
