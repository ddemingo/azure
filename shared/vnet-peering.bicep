param localVnetId string
param remoteVnetId string

var localVnetName = substring(localVnetId, lastIndexOf(localVnetId, '/') + 1)
var remoteVnetName = substring(remoteVnetId, lastIndexOf(remoteVnetId, '/') + 1)

resource localVnet 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name: localVnetName
}

resource remoteVnet 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name: remoteVnetName
}

resource localPeer 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-05-01' = {
  name: 'vnet-peering-${localVnetName}-${remoteVnetName}'
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

resource remotePeer 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-05-01' = {
  name: 'vnet-peering-${remoteVnetName}-${localVnetName}'
  parent: remoteVnet
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: false
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: localVnetId
    }
  }
}
