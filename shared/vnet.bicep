param location string

@description('10.x.0.0/16')
@minValue(1)
@maxValue(254)
param netId int

@description('Number of subnets to create')
param numberOfSubnets int = 1

@description('Create a vpn GatewaySubnet; it will be the first subnet from output.subnets')
param withGatewaySubnet bool = false

// https://docs.microsoft.com/en-us/azure/templates/microsoft.network/virtualnetworks?tabs=bicep
resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: 'vnet-${location}-10.${netId}'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.${netId}.0.0/16'
      ]
    }
    subnets: [for subnetId in range(1, numberOfSubnets): withGatewaySubnet && subnetId == 1 ? {
      name: 'GatewaySubnet'
      properties: {
        addressPrefix: '10.${netId}.${subnetId}.0/24'
      }
    } : {
      name: 'subnet-${location}-10.${netId}.${subnetId}'
      properties: {
        addressPrefix: '10.${netId}.${subnetId}.0/24'
        networkSecurityGroup: {
          id: nsg.id
        }
      }
    }]
  }
}

// https://docs.microsoft.com/en-us/azure/templates/microsoft.network/networksecuritygroups?tabs=bicep
resource nsg 'Microsoft.Network/networkSecurityGroups@2021-08-01' = if (withGatewaySubnet) {
  name: 'nsg-${location}-10.${netId}'
  location: location
  properties: {
    securityRules: []
  }
}

output vnetId string = vnet.id
output subnets array = vnet.properties.subnets
