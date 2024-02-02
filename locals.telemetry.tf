locals {
  module_name = "terraform-azurerm-avm-res-storage-storageaccount"
  # resource module
  module_type = "res"
  # This constructs the ARM deployment name that is used for the telemetry.
  # We shouldn't ever hit the 64 character limit but use substr just in case.
  telem_arm_deployment_name = substr(
    format(
      "%s.%s.%s.v%s.%s",
      local.telem_puid,
      local.module_type,
      substr(local.module_name, 0, 30),
      replace(local.module_version, ".", "-"),
      local.telem_random_hex
    ),
    0,
    64
  )
  # This is an empty ARM deployment template.
  telem_arm_template_content = <<TEMPLATE
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {},
  "variables": {},
  "resources": [],
  "outputs": {
    "telemetry": {
      "type": "String",
      "value": "Azure Verified Modules. For more information, see https://aka.ms/avm/telemetryinfo"
    }
  }
}
TEMPLATE
  # This is the unique id AVM Terraform modules that is supplied by the AVM team.
  # See https://azure.github.io/Azure-Verified-Modules/specs/shared/#id-sfr3---category-telemetry---deploymentusage-telemetry
  telem_puid = "46d3xgtf"
  # This ensures we don't get errors if telemetry is disabled.
  telem_random_hex = can(random_id.telemetry[0].hex) ? random_id.telemetry[0].hex : ""
}
