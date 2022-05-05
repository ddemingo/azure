param location string

@description('10.<id>.0.0/16')
@minValue(1)
@maxValue(254)
param id int

var subnet = 1

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: 'vnet-10.${id}'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.${id}.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'subnet-10.${id}.${subnet}'
        properties: {
          addressPrefix: '10.${id}.${subnet}.0/24'
        }
      }
    ]
  }
}

output vnetId string = vnet.id
output subnets array = vnet.properties.subnets
