# Validation
locals {
  appconfig_features = join(",", var.appconfig_features)
  appconfig_properties = join(",", var.appconfig_properties)
}

module "appconfig" {
  source            = "../.."
  appconfig_init_param = var.appconfig_init_param
  appconfig_features = local.appconfig_features
  appconfig_properties = local.appconfig_properties
  ibmcloud_api_key = var.ibmcloud_api_key
  appconfig_api_key = var.appconfig_api_key
  resource_group_id = var.resource_group_id
}

locals {
  configjson = module.appconfig.configjson
  worker_count = local.configjson.worker_count
  vpc_cluster_flavor = local.configjson.vpc_cluster_flavor
  prefix = local.configjson.prefix
  kms_config = local.configjson.kms_config
}


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