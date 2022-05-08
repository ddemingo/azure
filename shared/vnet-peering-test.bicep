module france 'vnet.bicep' = {
  name: 'france'
  params: {
    location: 'francecentral'
    id: 20
  }
}

module asia 'vnet.bicep' = {
  name: 'asia'
  params: {
    location: 'eastasia'
    id: 21
  }
}

module franceAsia 'vnet-peering.bicep' = {
  name: 'france-asia'
  params: {
    localVnetId: france.outputs.vnetId
    remoteVnetId: asia.outputs.vnetId
  }
}
