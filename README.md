# IBM Cloud App Configuration Evaluation module

This module helps to evaluate a list of properties & features in [IBM Cloud App Configuration](https://cloud.ibm.com/docs/app-configuration?topic=app-configuration-getting-started).  This module uses the [App Configuration Python SDK](https://cloud.ibm.com/docs/app-configuration?topic=app-configuration-ac-python) to evaluate the properties and feature. 

These evaluated values can be used to control the terraform deployment of your infrastructure.  For further reading on Feature flags in IaC refer [here](https://dzone.com/articles/revolutionizing-infrastructure-management-the-powe)

## Usage

```hcl
module "appconfig" {
  # Replace "master" with a GIT release version to lock into a specific release
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

