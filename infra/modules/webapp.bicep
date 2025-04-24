param location string
param appServiceName string
param appServerFarmName string
param tags object

param facekey string 
param visionkey string
param speechkey string
param openaikey string  

param faceendpoint string
param visionendpoint string 
param speechendpoint string
param openaiendpoint string

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' existing = {
  name: '${appServiceName}vnet'
  scope: resourceGroup()
}

resource web 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceName
  location: location
  tags: union(tags, { 'azd-service-name': 'web' })
  kind: 'app,linux'
  properties: {
    virtualNetworkSubnetId: vnet.properties.subnets[0].id
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'PYTHON|3.11'
      ftpsState: 'Disabled'
    }
    httpsOnly: true
  }
  identity: {
    type: 'SystemAssigned'
  }

  resource appSettings 'config' = {
    name: 'appsettings'
    properties: {
      SCM_DO_BUILD_DURING_DEPLOYMENT: 'true'
// read an environment variable from the azd env command
      FACE_KEY: facekey
      VISION_KEY: visionkey
      SPEECH_KEY: speechkey
      OPENAI_KEY: openaikey
      FACE_ENDPOINT: faceendpoint
      VISION_ENDPOINT: visionendpoint
      SPEECH_ENDPOINT: speechendpoint
      OPENAI_ENDPOINT: openaiendpoint
    }
  }

  resource logs 'config' = {
    name: 'logs'
    properties: {
      applicationLogs: {
        fileSystem: {
          level: 'Verbose'
        }
      }
      detailedErrorMessages: {
        enabled: true
      }
      failedRequestsTracing: {
        enabled: true
      }
      httpLogs: {
        fileSystem: {
          enabled: true
          retentionInDays: 1
          retentionInMb: 35
        }
      }
    }
  }
}
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServerFarmName
  location: location
  sku: {
    name: 'S1'
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}
output WEB_URI string = 'https://${web.properties.defaultHostName}'

