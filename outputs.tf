##############################################################################
# Outputs
##############################################################################

output "worker_count" {
  value       = local.configjson.worker_count
}

output "vpc_cluster_flavor" {
  value       = local.configjson.vpc_cluster_flavor
}

##############################################################################
