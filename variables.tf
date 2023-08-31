# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
    appconfig_id = string  # GUID of app configuration
    appconfig_region = string # region of app configuration
    appconfig_collection_id = string # collection id of app configuration
    appconfig_environment_id = string # environment id of app configuration
    entity_id = string # entity of app configuration for evaluation
    entity_attributes = string # entity attribute of app configuration which used for evaluation
  })
  description = "Input parameteres to IBM Cloud App Configuration SDK"
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
  type    = string
  description = "comma separated string of appconfig features to be evaluated"
  default = ""
}

variable appconfig_properties {
  type    = string
  description = "comma separated string of appconfig properties to be evaluated"
  default = ""
}

