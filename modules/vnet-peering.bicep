param localVnetId string
param remoteVnetId string

resource localVnet 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name: localVnetId
}

resource remoteVnet 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name: remoteVnetId
}

resource peer 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-05-01' = {
  name: 'vnet-peering-${localVnet.name}-${remoteVnet.name}'
  parent: localVnet
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: remoteVnetId
    }
  }
}
