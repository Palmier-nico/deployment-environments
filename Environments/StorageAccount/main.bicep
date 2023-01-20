@description('Location to deploy the environment resources')
param location string = resourceGroup().location

param name string = ''

param resourceName string = !empty(name) ? replace(name, ' ', '-') : 'a${uniqueString(resourceGroup().id)}'

var storageAcctName = toLower(replace(resourceName, '-', ''))

@description('Tags to apply to environment resources')
param tags object = {}

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: storageAcctName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  tags: tags
}
