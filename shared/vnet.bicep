param location string

@description('10.x.0.0/16')
@minValue(1)
@maxValue(254)
param secondIpByte int

@description('Number of subnets to create')
param numberOfSubnets int = 1

@description('Create a vpn GatewaySubnet; it will be the first subnet from output.subnets')
param createVpnGatewaySubnet bool = false

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: 'vnet-${location}-10.${secondIpByte}'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.${secondIpByte}.0.0/16'
      ]
    }
    subnets: [for thirdIpByte in range(1, numberOfSubnets): {
      name: createVpnGatewaySubnet && thirdIpByte == 1 ? 'GatewaySubnet' : 'subnet-${location}-10.${secondIpByte}.${thirdIpByte}'
      properties: {
        addressPrefix: '10.${secondIpByte}.${thirdIpByte}.0/24'
        networkSecurityGroup: {
          properties: {
            securityRules: [
              {
                properties: {
                  direction: 'Inbound'
                  protocol: '*'
                  access: 'Allow'
                }
              }
              {
                properties: {
                  direction: 'Outbound'
                  protocol: '*'
                  access: 'Allow'
                }
              }
            ]
          }
        }
      }
    }]
  }
}

output vnetId string = vnet.id
output subnets array = vnet.properties.subnets
