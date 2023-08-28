
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