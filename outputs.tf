##############################################################################
# Outputs
##############################################################################

output "configjson" {
  value   = jsondecode(data.local_file.config.content)
  description = "Evaluated values from App Configuration as output"
}
##############################################################################
