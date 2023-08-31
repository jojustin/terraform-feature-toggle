# IBM Cloud App Configuration Evaluation module

This module helps to evaluate a list of properties & features flags in [IBM Cloud App Configuration](https://cloud.ibm.com/docs/app-configuration?topic=app-configuration-getting-started).  This module uses the [App Configuration Python SDK](https://cloud.ibm.com/docs/app-configuration?topic=app-configuration-ac-python) to evaluate the properties and feature falgs. 

These evaluated values can be used to control the terraform deployment of your infrastructure.  For further reading on feature flags in IaC refer [here](https://dzone.com/articles/revolutionizing-infrastructure-management-the-powe)

## Usage

```hcl
module "appconfig" {
  source               = "git::https://github.com/jojustin/terraform-feature-toggle.git?ref=main"
  appconfig_init_param = {"appconfig_id":"guid-of-appconfig", "appconfig_region":"eu-gb", "appconfig_collection_id":"iac", "appconfig_environment_id":"dev", "entity_id":"iac", "entity_attributes" = "{\"region\": \"us-south\"}"}
  appconfig_features = "feature1, feature2"
  appconfig_properties = "property1, property2"
  ibmcloud_api_key = "ibmcloud-api-key"
  appconfig_api_key = "app-config-apikey"
  resource_group_id = "<resource group ID>"
}
```

## Examples

- [ Basic Example](examples/basic)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= v1.0.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.49.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | >= 1.49.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.2.1 |


## Resources

| Name | Type |
|------|------|
| [null_resource.appconfig_feature](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [ibm_iam_auth_token.token_data](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/iam_auth_token) | data source |
| [local_file.config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_appconfig_api_key"></a> [appconfig\_api\_key](#input\_appconfig\_api\_key) | APIkey that's associated with the appconfiguration instance | `string` | n/a | yes |
| <a name="input_appconfig_features"></a> [appconfig\_features](#input\_appconfig\_features) | comma separated string of appconfig features to be evaluated | `string` | `""` | no |
| <a name="input_appconfig_init_param"></a> [appconfig\_init\_param](#input\_appconfig\_init\_param) | Input parameteres to IBM Cloud App Configuration SDK | <pre>object({<br>    appconfig_id = string  # GUID of app configuration<br>    appconfig_region = string # region of app configuration<br>    appconfig_collection_id = string # collection id of app configuration<br>    appconfig_environment_id = string # environment id of app configuration<br>    entity_id = string # entity of app configuration for evaluation<br>    entity_attributes = string # entity attribute of app configuration which used for evaluation<br>  })</pre> | n/a | yes |
| <a name="input_appconfig_properties"></a> [appconfig\_properties](#input\_appconfig\_properties) | comma separated string of appconfig properties to be evaluated | `string` | `""` | no |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | APIkey that's associated with the account to use for infrastructure setup, set via environment variable TF\_VAR\_ibmcloud\_api\_key or .tfvars file. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region where resources will be created or fetched from | `string` | `"us-south"` | no |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource group ID where infra would be setup.  This RG should pre-exist | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_configjson"></a> [configjson](#output\_configjson) | config json from App Configuration as output |
<!-- END_TF_DOCS -->
