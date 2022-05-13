@secure()
param password string

var location = 'eastasia'

module vnet 'shared/vnet.bicep' = {
  name: 'asia-vnet'
  params: {
    location: location
    netId: 2
    numberOfSubnets: 2
  }
}

module vms 'shared/vm.bicep' = [for id in range(1, 2): {
  name: 'asia-vm-${id}'
  params: {
    location: location
    id: id
    subnetId: vnet.outputs.subnets[1].id
    adminPassword: password
    script: loadTextContent('apache.sh', 'utf-8')
  }
}]

output vnetId string = vnet.outputs.vnetId
