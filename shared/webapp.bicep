param storage_account_name string = 'asix${uniqueString(resourceGroup().id)}'
param sites_name string = 'asix-${uniqueString(resourceGroup().id)}'

@allowed([
  'nonprod'
  'prod'
])
param environment_type string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: storage_account_name
  location: 'westus3'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource appServicePlan 'Microsoft.Web/serverFarms@2021-03-01' = {
  name: 'web-server-farms'
  location: 'westus3'
  sku: {
    name: 'F1'
  }
}

resource appServiceApp 'Microsoft.Web/sites@2021-03-01' = {
  name: sites_name
  location: 'westus3'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
