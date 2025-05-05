[comment]: <> (please keep all comment items at the top of the markdown file)
[comment]: <> (please do not change the ***, as well as <div> placeholders for Note and Tip layout)
[comment]: <> (please keep the ### 1. and 2. titles as is for consistency across all demoguides)
[comment]: <> (section 1 provides a bullet list of resources + clarifying screenshots of the key resources details)
[comment]: <> (section 2 provides summarized step-by-step instructions on what to demo)


[comment]: <> (this is the section for the Note: item; please do not make any changes here)
***
# Azure AI Vision Project

<div style="background: lightgreen; 
            font-size: 14px; 
            color: black;
            padding: 5px; 
            border: 1px solid lightgray; 
            margin: 5px;">

**Note:** Below demo steps should be used **as a guideline** for doing your own demos. Please consider contributing to add additional demo steps.
</div>

[comment]: <> (this is the section for the Tip: item; consider adding a Tip, or remove the section between <div> and </div> if there is no tip)

This repository contains code designed to faciliate your experimentation and exploration with the Azure AI Vision service. 

Azure AI services help developers and organizations to rapidly create intelligent, cutting-edge, market-ready, and responsible applications with out-of-the-box and pre-built and customizable APIs and models. Example applications include natural language processing (NLP) for conversations, search, monitoring, translation, speech, vision, and decision-making.

Most Azure AI services are available through REST APIs and client library SDKs in popular development languages. For more information, see each service's documentation.

## Seeing the Wonderful World of AI with Azure AI Vision service
### Azure AI Vision - Image Analaysis

<img width="601" alt="image" src="https://github.com/user-attachments/assets/80c62579-fe5f-445d-b1ec-46c7a5f34ff3" />

***

### 1. What Resources are getting deployed


* rg-%azdenvironmentname - Azure Resource Group.
* app-face-%random% - App Service
* plan-face-%random% - App Plan
* app-face-%random%nsg - Network Security Group
* app-face-%random%vnet - Virtual Network
* cop-fa-face-%random% - Face API
* cog-oa-face-%random% - Azure OpenAI
* cog-sp-face-%random%  Speech Service
* cog-vi-face-%random% - Computer Vision

![image](https://github.com/user-attachments/assets/ea3e5c10-2962-4e88-96d2-d12f9c615668)

### 2. What can I demo from this scenario after deployment

https://github.com/user-attachments/assets/ad7d4fdd-71a3-4707-aab8-f69c4dda66c4

After the described in the [README.MD](../README.MD) is completeded, You will have a app service endpoint. For example...

![image](https://github.com/user-attachments/assets/9d8a4e00-bc48-47cb-83bc-4d13edd65bb6)

Navigate to that url and demonstrate the following AI Vision features

* Tags
* Caption
* Dense Captions
* Read (OCR)
* Smart Crops
* Objects
* People

You can use any publicly available image URL. `https://learn.microsoft.com/en-us/azure/ai-services/computer-vision/media/quickstarts/presentation.png` is the URL used in the demonstration.


[comment]: <> (this is the closing section of the demo steps. Please do not change anything here to keep the layout consistant with the other demoguides.)
<br></br>
***
<div style="background: lightgray; 
            font-size: 14px; 
            color: black;
            padding: 5px; 
            border: 1px solid lightgray; 
            margin: 5px;">

**Note:** This is the end of the current demo guide instructions.
</div>




