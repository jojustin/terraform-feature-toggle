# terraform-feature-toggle

___Note: This is a sample and is not for direct production use.___

This repository helps you deploy your infrastructure using Terraform, which is controlled by the feature toggle and centralized configuration management using IBM Cloud App Configuration.  

## Capabilities covered 

This sample encompasses the following capabilities:

* Retrieve and use configurations from a centralized configuration management to build and deploy Terraform modules.
* Evaluate segment based configurations to build and deploy Terraform modules. In this example, VPC cluster flavor varies based on the region of deployment.  This selection is established through IBM Cloud App Configuration segments and is appraised using the entity_attributes transmitted from Terraform to the App Configuration Python SDK.
* Assessing feature toggling based on segments for the construction and deployment of Terraform modules. In this case, the encryption of clusters serves as a toggleable feature that can be turned on or off. When activated, the value of this feature varies depending on the deployment region. This functionality is established using IBM Cloud App Configuration segments and is evaluated using the entity_attributes transmitted from Terraform to the App Configuration Python SDK.

## Folder structure
The details of the folder structure in this repository is as below - 

- __terraform\-feature\-toggle__
   - [LICENSE](LICENSE)
   - [README.md](README.md)
   - __appconfig\-python__ - Folder to contain the appconfiguration SDK code.
     - [app.py](appconfig-python/app.py) - Invokes app configuration sdk and writes the output to a file config.json
     - [config.json](appconfig-python/config.json) - Contains the evaluated features & properties
     - [python\_logs.txt](appconfig-python/python_logs.txt) - Logs generated out of the appconfig SDK code.
     - [sdk.py](appconfig-python/sdk.py) - Init & Evaluation of features and properties
   - [main.tf](main.tf) - Terraform main file to deploy the infrastructure with feature toggle usage
   - [outputs.tf](outputs.tf) - Outputs of the terraform deployment
   - [providers.tf](providers.tf) - Provider Configuration
   - __setup__
     - [exportedconfig.json](setup/exportedconfig.json) - File that can be used to import IBM Cloud App Configuration features & properties
   - [variables.tf](variables.tf) - Input variable definition
   - [version.tf](version.tf) - Manages terraform versions

## Setup Instructions

Following are the pre-requisites to run this tutorial

### Setup KMS instances 

This step is required only if cluster is encrypted using the kms_config in terraform.  

KMS instances to be setup as a pre-requisite and the corresponding guid of the instance & root key instance should be updated in to the feature flag values.  

* Setup a Key Protect or HPCS instances in IBM Cloud.  
* Note down the guid of the instance & root key id.  
* Update `enabled_value` in [exportedconfig.json](./setup/exportedconfig.json) to reflect the values for the dev & stage environments.

### Setup IBM Cloud App Configuration

* Create an IBM Cloud App Configuration instance.  This can be in any region as per the need.
* Install the [IBM Cloud App Configuration CLI](https://cloud.ibm.com/docs/app-configuration?topic=app-configuration-app-configuration-cli#ac-install-cli) if not already done.
* [Initialize the CLI plugin](https://cloud.ibm.com/docs/app-configuration?topic=app-configuration-app-configuration-cli#ac-ibmcloud-ac-init)
* Use IBM Cloud App Configuration [import](https://cloud.ibm.com/docs/app-configuration?topic=app-configuration-app-configuration-cli#ac-ibmcloud-ac-import) configuration CLI command to setup App Configuration instance. Use the [exportedconfig.json](./setup/exportedconfig.json) file for importing the required configuration.

## Run Terraform 

### Input variables information

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_appconfig_api_key"></a> [appconfig\_api\_key](#input\_appconfig\_api\_key) | APIkey that's associated with the appconfiguration instance | `string` | n/a | yes |
| <a name="input_appconfig_init_param"></a> [appconfig\_init\_param](#input\_appconfig\_init\_param) | App Configuration instance related information to evaluate features & properties | <pre>object({<br>    appconfig_id = string<br>    appconfig_region = string<br>    appconfig_collection_id = string<br>    appconfig_environment_id = string<br>    entity_id = string<br>  })</pre> | n/a | yes |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | APIkey that's associated with the account to use for infrastructure setup, set via environment variable TF\_VAR\_ibmcloud\_api\_key or .tfvars file. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region where resources will be created or fetched from | `string` | `"us-south"` | no |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource group ID where infra would be setup.  This RG should pre-exist | `string` | `"iactoggletest"` | no |

### Run terraform

* Run  `terraform init` to initializes Terraform configuration files
* Run `terraform plan` to create an execution plan
* Run `terraform apply` to execute the plan

Note: You can run `terraform apply -target=null_resource.appconfig_feature` in case app configuration python code is not executed.  This makes it run explicitly.