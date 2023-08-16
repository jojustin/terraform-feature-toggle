##############################################################################
# Input Variables
##############################################################################
variable "ibmcloud_api_key" {
  type        = string
  description = "APIkey that's associated with the account to use for infrastructure setup, set via environment variable TF_VAR_ibmcloud_api_key or .tfvars file."
  sensitive   = true
}

variable "appconfig_api_key" {
  type        = string
  description = "APIkey that's associated with the appconfiguration instance"
  sensitive   = true
}

variable "appconfig_init_param" {
  type = object({
    appconfig_id = string
    appconfig_region = string
    appconfig_collection_id = string
    appconfig_environment_id = string
    entity_id = string
  })
  description = "App Configuration instance related information to evaluate features & properties"
}

variable "resource_group_id" {
  type        = string
  description = "Resource group ID where infra would be setup.  This RG should pre-exist"
  default = "iactoggletest"
}

variable "region" {
  type        = string
  description = "Region where resources will be created or fetched from"
  default = "us-south"
}
