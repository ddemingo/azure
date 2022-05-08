var location = 'francecentral'

module vnet 'vnet.bicep' = {
  name: 'shared-vnet-test'
  params: {
    location: location
    netId: 100
    numberOfSubnets: 3
    withGatewaySubnet: true
  }
}

output subnet1 string = vnet.outputs.subnets[1].id
