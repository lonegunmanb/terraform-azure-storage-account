resource "azapi_resource" "queue" {
  type = "Microsoft.Storage/storageAccounts/queueServices/queues@2023-01-01"
  body = {
    properties = {
      metadata = var.metadata
    }
  }
  name                      = var.name
  parent_id                 = "${var.storage_account.resource_id}/queueServices/default"
  schema_validation_enabled = false
}



#Enable role assignments for queues
# resource "azurerm_role_assignment" "queues" {
#   for_each = local.queues_role_assignments

#   principal_id                           = each.value.role_assignment.principal_id
#   scope                                  = "${azurerm_storage_account.this.id}/queueServices/default/queues/${azapi_resource.queue[each.value.queue_key].name}"
#   condition                              = each.value.role_assignment.condition
#   condition_version                      = each.value.role_assignment.condition_version
#   delegated_managed_identity_resource_id = each.value.role_assignment.delegated_managed_identity_resource_id
#   role_definition_id                     = strcontains(lower(each.value.role_assignment.role_definition_id_or_name), lower(local.role_definition_resource_substring)) ? each.value.role_assignment.role_definition_id_or_name : null
#   role_definition_name                   = strcontains(lower(each.value.role_assignment.role_definition_id_or_name), lower(local.role_definition_resource_substring)) ? null : each.value.role_assignment.role_definition_id_or_name
#   skip_service_principal_aad_check       = each.value.role_assignment.skip_service_principal_aad_check
# }