##############################################################################
# Outputs
##############################################################################

output "configjson" {
  value   = jsondecode(data.local_file.config.content)
  description = "config json from App Configuration as output"
}
##############################################################################
