//Declare Parameters--------------------------------------------------------------------------------------------------------------------------
param location string
param principalId string
param ipAddress string
param openaiName string
param tags object = {}
param appServiceName string

resource openaiService 'Microsoft.CognitiveServices/accounts@2023-05-01' = {
  name: openaiName
  location: location
  tags: tags
  sku: {
    name: 'S0'
  }
  kind: 'OpenAI'
  properties: {
    customSubDomainName: openaiName
    apiProperties: {
      statisticsEnabled: false
    }
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
  //dependsOn: [
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

resource gptDeployment 'Microsoft.CognitiveServices/accounts/deployments@2023-05-01' = {
  parent: openaiService
  name: 'gpt-4o'
  properties: {
    model: {
      format: 'OpenAI'
      name: 'gpt-4o'
      version: '2024-05-13'
    }
  }
  sku: {
    capacity: 10
    name: 'Standard'
  }
}

resource openaiServiceUserRole 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: '5e0bd9bd-7b93-4f28-af87-19fc36ad61bd' // Cognitive Services OpenAI User
}

resource openaiServiceRBAC 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(principalId, openaiService.id, openaiServiceUserRole.id)
  properties: {
    description: 'User role assignment for OpenAI Service'
    principalId: principalId
    principalType: 'User'
    roleDefinitionId: openaiServiceUserRole.id
  }
}

output endpoint string = openaiService.properties.endpoint
output openaiid string = openaiService.id
output deploymentName string = gptDeployment.name
#disable-next-line outputs-should-not-contain-secrets // Don't use this in production, it's just for testing purposes.
output apikey string = openaiService.listKeys().key1
