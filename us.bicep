var location = 'westus'

module vnet 'shared/vnet.bicep' = {
  name: 'us-vnet'
  params: {
    location: location
    netId: 3
    numberOfSubnets: 2
  }
}
