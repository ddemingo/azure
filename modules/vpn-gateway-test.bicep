var location = 'westus'

module vnet 'vnet.bicep' = {
  name: 'vnet'
  params: {
    location: location
    secondIpByte: 200
    numberOfSubnets: 2
    createVpnGatewaySubnet: true
  }
}

module vpnGateway 'vpn-gateway.bicep' = {
  name: 'vpn-gateway'
  params: {
    location: location
    subnetId: vnet.outputs.subnets[0].id
    asn: 65010
  }
}
