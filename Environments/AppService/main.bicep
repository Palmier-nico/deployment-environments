
// param webAppName string = uniqueString(resourceGroup().id) // Generate unique String for web app name
param webAppName string = 'mtc-webapp-nodejs'
param sku string = 'F1' // The SKU of App Service Plan
param linuxFxVersion string = 'node|14-lts' // The runtime stack of web app
param location string = resourceGroup().location // Location for all resources
// param repositoryUrl string = 'https://github.com/Azure-Samples/nodejs-docs-hello-world'
// param branch string = 'master'
var appServicePlanName = toLower('AppServicePlan-${webAppName}')
// var appServicePlanName = toLower('AppServicePlan-${webAppName}')
var webSiteName = toLower('wapp-${webAppName}')


resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  properties: {
    reserved: true
  }
  sku: {
    name: sku
  }
  kind: 'linux'
}
resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: webSiteName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
    }
  }
}
