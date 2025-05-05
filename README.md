# Azure AI Vision Project

This repository contains code designed to faciliate your experimentation and exploration with the Azure AI Vision service. 

Azure AI services help developers and organizations to rapidly create intelligent, cutting-edge, market-ready, and responsible applications with out-of-the-box and pre-built and customizable APIs and models. Example applications include natural language processing (NLP) for conversations, search, monitoring, translation, speech, vision, and decision-making.

Most Azure AI services are available through REST APIs and client library SDKs in popular development languages. For more information, see each service's documentation.

## Seeing the Wonderful World of AI with Azure AI Vision service
### Azure AI Vision - Image Analaysis
<br>

### Prerequisites
- Python (>= 3.8)
- Visual Studio Code
- [Azure Developer CLI - AZD](https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/install-azd)
    - When installing AZD, the above the following tools will be installed on your machine as well, if not already installed:
        - [GitHub CLI](https://cli.github.com)
        - [Bicep CLI](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install)
    - You need Owner or Contributor access permissions to an Azure Subscription to  deploy the scenario.

## 🚀 Cloning the scenario in 4 steps:

1. Create a new folder on your machine.
```
mkdir azd-vision-face
```
2. Next, navigate to the new folder.
```
cd azd-vision-face
```
3. Next, run `azd init` to initialize the deployment.
```
azd init -t VincentK16/azd-vision-face
```
4. Finally, run `azd up` to deploy the needed azure resources
```
azd up
```

### Demo Guide

Take a look at the [Demo Guide](./demoguide/demoguide.md) for demo details.

