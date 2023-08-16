locals {
  python = (substr(pathexpand("~"), 0, 1) == "/") ? "python3" : "python.exe"
  working_dir_python = "${path.module}/appconfig-python"
}

## evaluate App Configuration features and properties using python code.
resource "null_resource" "appconfig_feature" {
  provisioner "local-exec" {
    command = "${local.python} -m app '${var.appconfig_init_param.appconfig_region}' '${var.appconfig_init_param.appconfig_id}' '${var.appconfig_api_key}' '${var.appconfig_init_param.appconfig_collection_id}' '${var.appconfig_init_param.appconfig_environment_id}' '${var.appconfig_init_param.entity_id}' '${var.region}' > python_logs.txt"
    interpreter = ["/bin/bash", "-c"]
    working_dir = local.working_dir_python
  }
  triggers = {
    always_run = "${timestamp()}"
  }
}

# File that contains the configuration as a json 
# This configuration is the result of evaluation done with App Configuration for properties and features
data "local_file" "config" {
  filename = "appconfig-python/config.json"
}

# Assign evaluated values to the local variables. 
locals {
  configjson = jsondecode(data.local_file.config.content)
  worker_count = local.configjson.worker_count
  vpc_cluster_flavor = local.configjson.vpc_cluster_flavor
  prefix = local.configjson.prefix
  kms_config = local.configjson.kms_config
}

#Uncomment & Run this once to create kms instances & provide this as the input to app config kms_config feature
# resource "ibm_resource_instance" "kms_instance1" {
#     name              = "test_kms"
#     service           = "kms"
#     plan              = "tiered-pricing"
#     location          = "us-south"
# }
  
# resource "ibm_kms_key" "test" {
#     instance_id = "${ibm_resource_instance.kms_instance1.guid}"
#     key_name = "test_root_key"
#     standard_key =  false
#     force_delete = true
# }

data ibm_resource_group "resource_group" {
    name = var.resource_group_id
}

resource "ibm_is_vpc" "vpc1" {
  name = "vpc"
  resource_group = data.ibm_resource_group.resource_group.id
}

resource "ibm_is_subnet" "subnet1" {
  name                     = "${local.prefix}-subnet"
  vpc                      = ibm_is_vpc.vpc1.id
  zone                     = "${var.region}-1"
  total_ipv4_address_count = 256
  resource_group = data.ibm_resource_group.resource_group.id
}


resource "ibm_container_vpc_cluster" "cluster" {
  name              = "${local.prefix}-vpccluster"
  vpc_id            = ibm_is_vpc.vpc1.id
  flavor            = local.vpc_cluster_flavor
  worker_count      = local.worker_count
  resource_group_id = data.ibm_resource_group.resource_group.id
  zones {
    subnet_id = ibm_is_subnet.subnet1.id
    name      = "${var.region}-1"
  }

dynamic "kms_config" {
    for_each = local.kms_config != null && local.kms_config != {} ? [1] : []
    content {
      crk_id           = local.kms_config.crk_id
      instance_id      = local.kms_config.instance_id
      private_endpoint = local.kms_config.private_endpoint == null ? true : local.kms_config.private_endpoint
    }
  }
}