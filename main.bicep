param location string = 'francecentral'

module vnet 'modules/vnet.bicep' = {
  name: 'vnet-test'
  params: {
    location: location
    id: 5
  }
}

module vnet2 'modules/vnet.bicep' = {
  name: 'vnet-test2'
  params: {
    location: 'westeurope'
    id: 5
  }
}

module peer 'modules/vnet-peering.bicep' = {
  name: 'peer'
  params: {
    localVnetId: vnet.outputs.vnetId
    remoteVnetId: vnet2.outputs.vnetId
  }
}
