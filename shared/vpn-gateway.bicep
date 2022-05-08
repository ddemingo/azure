// https://docs.microsoft.com/en-us/azure/vpn-gateway/

param location string

@description('Subnet to connect the VM to.')
param subnetId string

@description('BGP AS-number to use for the VPN Gateway')
param asn int

resource ip 'Microsoft.Network/publicIPAddresses@2020-06-01' = {
  name: 'ip-vpn-gateway'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource vpnGateway 'Microsoft.Network/virtualNetworkGateways@2020-06-01' = {
  name: 'vpnGateway'
  location: location
  properties: {
    gatewayType: 'Vpn'
    ipConfigurations: [
      {
        name: 'default'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnetId
          }
          publicIPAddress: {
            id: ip.id
          }
        }
      }
    ]
    activeActive: false
    enableBgp: true
    bgpSettings: {
      asn: asn
    }
    vpnType: 'RouteBased'
    vpnGatewayGeneration: 'Generation1'
    sku: {
      name: 'VpnGw1AZ'
      tier: 'VpnGw1AZ'
    }
  }
}

output ip string = ip.properties.ipAddress
