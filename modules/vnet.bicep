param location string

@minValue(1)
@maxValue(254)
param id int

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: 'vnet-${location}'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.${id}.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'vnet-${location}-0'
        properties: {
          addressPrefix: '10.${id}.0.0/24'
        }
      }
    ]
  }
}

output name string = vnet.name
output vnetId string = vnet.id
output subnetId string = vnet.properties.subnets[0].id
