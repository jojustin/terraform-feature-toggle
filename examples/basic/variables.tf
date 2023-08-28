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

variable "resource_group_id" {
  type        = string
  description = "Resource group ID where infra would be setup.  This RG should pre-exist"
  default = null
}

variable "region" {
  type        = string
  description = "Region where resources will be created or fetched from"
  default = "us-south"
}

variable appconfig_features {
  type    = list(string)
  default = ["kms_config"]
}

variable appconfig_properties {
  type    = list(string)
  default = ["worker_count", "vpc_cluster_flavor", "prefix"]
}

variable "appconfig_init_param" {
  type = object({
    appconfig_id = string
    appconfig_region = string
    appconfig_collection_id = string
    appconfig_environment_id = string
    entity_id = string
    entity_attributes = string
  })
  description = "Input parameteres to IBM Cloud App Configuration SDK"
}

