var location = 'westus'

module vnet 'modules/vnet.bicep' = {
  name: 'us-vnet'
  params: {
    location: location
    secondIpByte: 3
    numberOfSubnets: 2
    createVpnGatewaySubnet: true
  }
}

module vpnGateway 'modules/vpn-gateway.bicep' = {
  name: 'us-vpn-gateway'
  params: {
    location: location
    subnetId: vnet.outputs.subnets[0].id
    asn: 65010
  }
}
