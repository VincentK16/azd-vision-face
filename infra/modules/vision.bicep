param location string
param visionServiceName string
param principalId string
param ipAddress string
param tags object = {}
param appServiceName string

// Create vision Service resource
resource visionService 'Microsoft.CognitiveServices/accounts@2024-10-01' = {
  name: visionServiceName
  location: location
  kind: 'ComputerVision'
  sku: {
    name: 'F0'
    }
  properties: {
    customSubDomainName: visionServiceName // Set the custom subdomain name for the vision Service
    disableLocalAuth: false // for now do support api key authentication
    publicNetworkAccess: (ipAddress != '') ? 'Enabled' : 'Disabled'
    networkAcls: (ipAddress != '') ? {
      defaultAction: 'Deny'
      ipRules: [
          {value: ipAddress}
      ]
      virtualNetworkRules: [
        {
          id: subnet.id
          ignoreMissingVnetServiceEndpoint: false
        }
      ]
    } : null
  }
  tags: tags
}
resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' existing = {
  name: '${appServiceName}vnet'
  
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2020-06-01' existing = {
  parent: vnet
  name: '${appServiceName}sn'
}

resource visionServiceUserRole 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: '93586559-c37d-4a6b-ba08-b9f0940c2d73' // Cognitive Services custom vision User
}

resource visionServiceRBAC 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(principalId, visionService.id, visionServiceUserRole.id)
  properties: {
    description: 'User role assignment for vision Service'
    principalId: principalId
    principalType: 'User'
    roleDefinitionId: visionServiceUserRole.id
  }
}

output visionid string = visionService.id
output endpoint string = visionService.properties.endpoint
#disable-next-line outputs-should-not-contain-secrets // Don't use this in production, it's just for testing purposes.
output apikey string = visionService.listKeys().key1
