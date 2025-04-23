param location string
param tags object
param appServiceName string



var vnetName = '${appServiceName}vnet'
var vnetAddressPrefix = '10.0.0.0/16'
var subnetName = '${appServiceName}sn'
var subnetAddressPrefix = '10.0.0.0/24'

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]

    }
    
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetAddressPrefix
          serviceEndpoints: [
            {
              service: 'Microsoft.CognitiveServices'
              locations: [
                '*'
              ]
            }
          ]
          delegations: [
            {
              name: 'delegation'
              id: resourceId('Microsoft.Network/virtualNetworks/subnets/delegations', vnetName, subnetName, 'delegation')
              properties: {
                serviceName: 'Microsoft.Web/serverFarms'
              }
              
            }
          
          ]

        }
      }
    ]
  }
}








output VNET string = vnet.id
output SUBNET string = vnet.properties.subnets[0].id
