param location string
param faceServiceName string
param principalId string
param ipAddress string
param tags object = {}

// Create face Service resource
resource faceService 'Microsoft.CognitiveServices/accounts@2022-03-01' = {
  name: faceServiceName
  location: location
  kind: 'Face'
  sku: {
    name: 'S0'
    tier: 'Standard'
  }
  properties: {
    customSubDomainName: faceServiceName // Set the custom subdomain name for the face Service
    disableLocalAuth: false // for now do not support api key authentication
    publicNetworkAccess: (ipAddress != '') ? 'Enabled' : 'Disabled'
    networkAcls: (ipAddress != '') ? {
      defaultAction: 'Deny'
      ipRules: [
          {value: ipAddress}
      ]
    } : null
  }
  tags: tags
}

resource faceServiceUserRole 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: '9894cab4-e18a-44aa-828b-cb588cd6f2d7' // Cognitive Services face Recognizer
}

resource faceServiceRBAC 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(principalId, faceService.id, faceServiceUserRole.id)
  properties: {
    description: 'User role assignment for face Service'
    principalId: principalId
    principalType: 'User'
    roleDefinitionId: faceServiceUserRole.id
  }
}

output faceid string = faceService.id
output endpoint string = faceService.properties.endpoint
#disable-next-line outputs-should-not-contain-secrets // Don't use this in production, it's just for testing purposes.
output apikey string = faceService.listKeys().key1
