param location string
param speechServiceName string
param principalId string
param ipAddress string
param tags object = {}
param appServiceName string

// Create Speech Service resource
resource speechService 'Microsoft.CognitiveServices/accounts@2022-03-01' = {
  name: speechServiceName
  location: location
  kind: 'SpeechServices'
  sku: {
    name: 'S0'
    tier: 'Standard'
  }
  properties: {
    customSubDomainName: speechServiceName // Set the custom subdomain name for the Speech Service
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
  //dependsOn: [
  //  
  //  subnet
  //]
}
resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' existing = {
  name: '${appServiceName}vnet'
  
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2020-06-01' existing = {
  parent: vnet
  name: '${appServiceName}sn'
}

resource speechServiceUserRole 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: 'f2dc8367-1007-4938-bd23-fe263f013447' // Cognitive Services Speech User
}

resource speechServiceRBAC 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(principalId, speechService.id, speechServiceUserRole.id)
  properties: {
    description: 'User role assignment for Speech Service'
    principalId: principalId
    principalType: 'User'
    roleDefinitionId: speechServiceUserRole.id
  }
}

output speechid string = speechService.id
output endpoint string = speechService.properties.endpoint
#disable-next-line outputs-should-not-contain-secrets // Don't use this in production, it's just for testing purposes.
output apikey string = speechService.listKeys().key1
