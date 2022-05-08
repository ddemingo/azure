var password = 'P@ssw0rdxxxx'

module france 'france.bicep' = {
  name: 'france'
  params: {
    password: password
  }
}

module asia 'asia.bicep' = {
  name: 'asia'
  params: {
    password: password
  }
}

module franceAsia 'shared/vnet-peering.bicep' = {
  name: 'peer-france-asia'
  params: {
    localVnetId: france.outputs.vnetId
    remoteVnetId: asia.outputs.vnetId
  }
}
