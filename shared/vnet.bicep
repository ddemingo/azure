param location string

@description('10.x.0.0/16')
@minValue(1)
@maxValue(254)
param netId int

@description('Number of subnets to create')
param numberOfSubnets int = 1

@description('Create a vpn GatewaySubnet; it will be the first subnet from output.subnets')
param createVpnGatewaySubnet bool = false

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: 'vnet-${location}-10.${netId}'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.${netId}.0.0/16'
      ]
    }
    subnets: [for subnetId in range(1, numberOfSubnets): {
      name: createVpnGatewaySubnet && subnetId == 1 ? 'GatewaySubnet' : 'subnet-${location}-10.${netId}.${subnetId}'
      properties: {
        addressPrefix: '10.${netId}.${subnetId}.0/24'
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
