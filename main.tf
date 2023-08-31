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

locals {
  python = (substr(pathexpand("~"), 0, 1) == "/") ? "python3" : "python.exe"
  working_dir_python = "${path.module}/appconfig-python"
  
}

# Execute IBM Cloud App Configruation Python SDK to evalute properties & features 
resource "null_resource" "appconfig_feature" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "${local.python} -m app '${var.appconfig_init_param.appconfig_region}' '${var.appconfig_init_param.appconfig_id}' '${var.appconfig_api_key}' '${var.appconfig_init_param.appconfig_collection_id}' '${var.appconfig_init_param.appconfig_environment_id}' '${var.appconfig_init_param.entity_id}' '${var.appconfig_init_param.entity_attributes}'  '${var.region}' '${var.appconfig_features}' '${var.appconfig_properties}' > python_logs.txt"
    interpreter = ["/bin/bash", "-c"]
    working_dir = local.working_dir_python
  }
}

# File that contains the configuration as a json 
# This configuration is the result of evaluation done with App Configuration for properties and features
data "local_file" "config" {
  filename = "${local.working_dir_python}/config.json"
}