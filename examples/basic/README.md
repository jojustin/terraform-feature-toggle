# Basic example

This example is a basic example which uses IBM Cloud App Configuration evaluation to create infrastruture.
* This module can evaluate a list of properties & features in IBM Cloud App Configuration.  
* This module can use the evaluated results to decide the infrastructure deployment using Terraform.

# Setup IBM Cloud App Configuration

Before you run the Basic example, IBM Cloud App Configuration instance should be added with properties and feature flags required to run the example.  

## Create an IBM Cloud App Configuration instance

Create an [IBM Cloud App Configuration instance](https://cloud.ibm.com/catalog/services/app-configuration) to use with this example.  

## Install the IBM Cloud App Configuration CLI

Install the [IBM Cloud App Configuration CLI](https://cloud.ibm.com/docs/app-configuration?topic=app-configuration-app-configuration-cli) so that the required configuration for this sample can be imported. 

## Import configruation 

Before importing the configuration intialize the plugin using the below command - 

`ibmcloud ac init --instance_id <guid of the app conifiguration instance>`

Required configuration for the sample is available in the [setup](../setup/exportedconfig.json) folder.

Import the configuration using the below command - 

`ibmcloud ac import --file <exportedconfig.json folder>`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= v1.0.0 |
| <a name="requirement_external"></a> [external](#requirement\_external) | 2.3.1 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.49.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | 1.56.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_appconfig"></a> [appconfig](#module\_appconfig) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [ibm_container_vpc_cluster.cluster](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/container_vpc_cluster) | resource |
| [ibm_is_subnet.subnet1](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_subnet) | resource |
| [ibm_is_vpc.vpc1](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/is_vpc) | resource |
| [ibm_iam_auth_token.token_data](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/iam_auth_token) | data source |
| [ibm_resource_group.resource_group](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_appconfig_api_key"></a> [appconfig\_api\_key](#input\_appconfig\_api\_key) | APIkey that's associated with the appconfiguration instance | `string` | n/a | yes |
| <a name="input_appconfig_features"></a> [appconfig\_features](#input\_appconfig\_features) | n/a | `list(string)` | <pre>[<br>  "kms_config"<br>]</pre> | no |
| <a name="input_appconfig_init_param"></a> [appconfig\_init\_param](#input\_appconfig\_init\_param) | Input parameteres to IBM Cloud App Configuration SDK | <pre>object({<br>    appconfig_id = string<br>    appconfig_region = string<br>    appconfig_collection_id = string<br>    appconfig_environment_id = string<br>    entity_id = string<br>    entity_attributes = string<br>  })</pre> | n/a | yes |
| <a name="input_appconfig_properties"></a> [appconfig\_properties](#input\_appconfig\_properties) | n/a | `list(string)` | <pre>[<br>  "worker_count",<br>  "vpc_cluster_flavor",<br>  "prefix"<br>]</pre> | no |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | APIkey that's associated with the account to use for infrastructure setup, set via environment variable TF\_VAR\_ibmcloud\_api\_key or .tfvars file. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region where resources will be created or fetched from | `string` | `"us-south"` | no |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource group ID where infra would be setup.  This RG should pre-exist | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_configjson"></a> [configjson](#output\_configjson) | ############################################################################# Outputs ############################################################################# |
<!-- END_TF_DOCS -->