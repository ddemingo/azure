var location = 'westus'

module vnet 'shared/vnet.bicep' = {
  name: 'us-vnet'
  params: {
    location: location
    netId: 3
    numberOfSubnets: 2
    createVpnGatewaySubnet: true
  }
}

module vpnGateway 'shared/vpn-gateway.bicep' = {
  name: 'us-vpn-gateway'
  params: {
    location: location
    subnetId: vnet.outputs.subnets[0].id
    asn: 65010
  }
}
