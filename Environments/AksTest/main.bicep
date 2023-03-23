@description('The name of the Managed Cluster resource.')
param name string = ''

param resourceName string = !empty(name) ? replace(name, ' ', '-') : 'a${uniqueString(resourceGroup().id)}'

var clusterName = toLower(replace(resourceName, '-', ''))

@description('The location of the Managed Cluster resource.')
param location string = resourceGroup().location

param nodeCount int = 3
param vmSize string = 'standard_d2s_v3'

resource aks 'Microsoft.ContainerService/managedClusters@2021-05-01' = {
  name: clusterName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: clusterName
    enableRBAC: true
    agentPoolProfiles: [
      {
        name: '${clusterName}ap1'
        count: nodeCount
        vmSize: vmSize
        mode: 'System'
      }
    ]
  }
}
