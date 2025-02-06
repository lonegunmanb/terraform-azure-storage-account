<!-- BEGIN_TF_DOCS -->
# Terraform Azure Storage Account Module

This Terraform module is designed to create Azure Storage Accounts and its related resources, including blob containers, queues, tables, and file shares. It also supports the creation of a storage account private endpoint which provides secure and direct connectivity to Azure Storage over a private network.

> [!WARNING]
> Major version Zero (0.y.z) is for initial development. Anything MAY change at any time. A module SHOULD NOT be considered stable till at least it is major version one (1.0.0) or greater. Changes will always be via new versions being published and no changes will be made to existing published versions. For more details please go to <https://semver.org/>

## Features

* Create a storage account with various configuration options such as account kind, tier, replication type, network rules, and identity settings.
* Create blob containers, queues, tables, and file shares within the storage account.
* Support for customer-managed keys for encrypting the data in the storage account.
* Enable private endpoint for the storage account, providing secure access over a private network.

## Limitations

* The storage account name must be globally unique.
* The module creates resources in the same region as the storage account.

> **IMPORTANT** We recommend using Azure AD authentication over Shared Key for provisioning Storage Containers, Blobs, and other items. To achieve this, add the `storage_use_azuread` flag in the Provider block. However, it’s important to note that not all Azure Storage services support Active Directory authentication.(https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#storage_use_azuread) In the absence of the `storage_use_azuread` flag, you will need to enable Shared Key Access by setting the `shared_access_key_enabled` flag `True`.

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.7.0)

- <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) (>= 1.14.0, < 3.0.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 3.116.0, < 5.0.0)

- <a name="requirement_modtm"></a> [modtm](#requirement\_modtm) (~> 0.3)

- <a name="requirement_random"></a> [random](#requirement\_random) (>= 3.5.0, < 4.0.0)

## Resources

The following resources are used by this module:

- [azapi_resource.containers](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (resource)
- [azapi_resource.queue](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (resource)
- [azapi_resource.share](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (resource)
- [azapi_resource.table](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (resource)
- [azurerm_management_lock.this_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) (resource)
- [azurerm_monitor_diagnostic_setting.azure_file](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) (resource)
- [azurerm_monitor_diagnostic_setting.blob](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) (resource)
- [azurerm_monitor_diagnostic_setting.queue](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) (resource)
- [azurerm_monitor_diagnostic_setting.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) (resource)
- [azurerm_monitor_diagnostic_setting.table](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) (resource)
- [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) (resource)
- [azurerm_private_endpoint.this_unmanaged_dns_zone_groups](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) (resource)
- [azurerm_private_endpoint_application_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint_application_security_group_association) (resource)
- [azurerm_role_assignment.containers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_role_assignment.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_role_assignment.queues](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_role_assignment.shares](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_role_assignment.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_role_assignment.tables](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) (resource)
- [azurerm_storage_account_customer_managed_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_customer_managed_key) (resource)
- [azurerm_storage_account_local_user.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_local_user) (resource)
- [azurerm_storage_data_lake_gen2_filesystem.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_data_lake_gen2_filesystem) (resource)
- [azurerm_storage_management_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) (resource)
- [azurerm_storage_share_directory.directories](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share_directory) (resource)
- [modtm_telemetry.telemetry](https://registry.terraform.io/providers/Azure/modtm/latest/docs/resources/telemetry) (resource)
- [random_uuid.telemetry](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) (resource)
- [azurerm_client_config.telemetry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) (data source)
- [modtm_module_source.telemetry](https://registry.terraform.io/providers/Azure/modtm/latest/docs/data-sources/module_source) (data source)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_location"></a> [location](#input\_location)

Description: Azure region where the resource should be deployed.  
If null, the location will be inferred from the resource group location.

Type: `string`

### <a name="input_name"></a> [name](#input\_name)

Description: The name of the resource.

Type: `string`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: The resource group where the resources will be deployed.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier)

Description: (Optional) Defines the access tier for `BlobStorage`, `FileStorage` and `StorageV2` accounts. Valid options are `Hot` and `Cool`, defaults to `Hot`.

Type: `string`

Default: `"Hot"`

### <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind)

Description: (Optional) Defines the Kind of account. Valid options are `BlobStorage`, `BlockBlobStorage`, `FileStorage`, `Storage` and `StorageV2`. Defaults to `StorageV2`.

Type: `string`

Default: `"StorageV2"`

### <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type)

Description: (Required) Defines the type of replication to use for this storage account. Valid options are `LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS` and `RAGZRS`.  Defaults to `ZRS`

Type: `string`

Default: `"ZRS"`

### <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier)

Description: (Required) Defines the Tier to use for this storage account. Valid options are `Standard` and `Premium`. For `BlockBlobStorage` and `FileStorage` accounts only `Premium` is valid. Changing this forces a new resource to be created.

Type: `string`

Default: `"Standard"`

### <a name="input_allow_nested_items_to_be_public"></a> [allow\_nested\_items\_to\_be\_public](#input\_allow\_nested\_items\_to\_be\_public)

Description: (Optional) Allow or disallow nested items within this Account to opt into being public. Defaults to `false`.

Type: `bool`

Default: `false`

### <a name="input_allowed_copy_scope"></a> [allowed\_copy\_scope](#input\_allowed\_copy\_scope)

Description: (Optional) Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Possible values are `AAD` and `PrivateLink`.

Type: `string`

Default: `null`

### <a name="input_azure_files_authentication"></a> [azure\_files\_authentication](#input\_azure\_files\_authentication)

Description: - `directory_type` - (Required) Specifies the directory service used. Possible values are `AADDS`, `AD` and `AADKERB`.
- `default_share_level_permission` - (Optional) Specifies the default share level permissions applied to all users. Possible values are StorageFileDataSmbShareReader, StorageFileDataSmbShareContributor, StorageFileDataSmbShareElevatedContributor, or None.

---
`active_directory` block supports the following:
- `domain_guid` - (Required) Specifies the domain GUID.
- `domain_name` - (Required) Specifies the primary domain that the AD DNS server is authoritative for.
- `domain_sid` - (Required) Specifies the security identifier (SID).
- `forest_name` - (Required) Specifies the Active Directory forest.
- `netbios_domain_name` - (Required) Specifies the NetBIOS domain name.
- `storage_sid` - (Required) Specifies the security identifier (SID) for Azure Storage.

Type:

```hcl
object({
    directory_type                 = optional(string, "AADKERB")
    default_share_level_permission = optional(string)

    active_directory = optional(object({
      domain_guid         = string
      domain_name         = string
      domain_sid          = string
      forest_name         = string
      netbios_domain_name = string
      storage_sid         = string
    }))
  })
```

Default: `null`

### <a name="input_blob_properties"></a> [blob\_properties](#input\_blob\_properties)

Description: - `change_feed_enabled` - (Optional) Is the blob service properties for change feed events enabled? Default to `false`.
- `change_feed_retention_in_days` - (Optional) The duration of change feed events retention in days. The possible values are between 1 and 146000 days (400 years). Setting this to null (or omit this in the configuration file) indicates an infinite retention of the change feed.
- `default_service_version` - (Optional) The API Version which should be used by default for requests to the Data Plane API if an incoming request doesn't specify an API Version.
- `last_access_time_enabled` - (Optional) Is the last access time based tracking enabled? Default to `false`.
- `versioning_enabled` - (Optional) Is versioning enabled? Default to `false`.

---
`container_delete_retention_policy` block supports the following:
- `days` - (Optional) Specifies the number of days that the container should be retained, between `1` and `365` days. Defaults to `7`.

---
`cors_rule` block supports the following:
- `allowed_headers` - (Required) A list of headers that are allowed to be a part of the cross-origin request.
- `allowed_methods` - (Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are `DELETE`, `GET`, `HEAD`, `MERGE`, `POST`, `OPTIONS`, `PUT` or `PATCH`.
- `allowed_origins` - (Required) A list of origin domains that will be allowed by CORS.
- `exposed_headers` - (Required) A list of response headers that are exposed to CORS clients.
- `max_age_in_seconds` - (Required) The number of seconds the client should cache a preflight response.

---
`delete_retention_policy` block supports the following:
- `days` - (Optional) Specifies the number of days that the blob should be retained, between `1` and `365` days. Defaults to `7`.

---
`diagnostic_settings` block supports the following:
- `name` - (Optional) The name of the diagnostic setting. Defaults to `null`.
- `log_categories` - (Optional) A set of log categories to enable. Defaults to an empty set.
- `log_groups` - (Optional) A set of log groups to enable. Defaults to `["allLogs"]`.
- `metric_categories` - (Optional) A set of metric categories to enable. Defaults to `["AllMetrics"]`.
- `log_analytics_destination_type` - (Optional) The destination type for log analytics. Defaults to `"Dedicated"`.
- `workspace_resource_id` - (Optional) The resource ID of the Log Analytics workspace. Defaults to `null`.
- `resource_id` - (Optional) The resource ID of the target resource for diagnostics. Defaults to `null`.
- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the Event Hub authorization rule. Defaults to `null`.
- `event_hub_name` - (Optional) The name of the Event Hub. Defaults to `null`.
- `marketplace_partner_resource_id` - (Optional) The resource ID of the marketplace partner. Defaults to `null`.

---
`restore_policy` block supports the following:
- `days` - (Required) Specifies the number of days that the blob can be restored, between `1` and `365` days. This must be less than the `days` specified for `delete_retention_policy`.

Type:

```hcl
object({
    change_feed_enabled           = optional(bool)
    change_feed_retention_in_days = optional(number)
    default_service_version       = optional(string)
    last_access_time_enabled      = optional(bool)
    versioning_enabled            = optional(bool, true)
    container_delete_retention_policy = optional(object({
      days = optional(number, 7)

    }), { days = 7 })

    cors_rule = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })))
    delete_retention_policy = optional(object({
      days = optional(number, 7)
    }), { days = 7 })
    diagnostic_settings = optional(map(object({
      name                                     = optional(string, null)
      log_categories                           = optional(set(string), [])
      log_groups                               = optional(set(string), ["allLogs"])
      metric_categories                        = optional(set(string), ["AllMetrics"])
      log_analytics_destination_type           = optional(string, "Dedicated")
      workspace_resource_id                    = optional(string, null)
      resource_id                              = optional(string, null)
      event_hub_authorization_rule_resource_id = optional(string, null)
      event_hub_name                           = optional(string, null)
      marketplace_partner_resource_id          = optional(string, null)
    })), {})
    restore_policy = optional(object({
      days = number
    }))
  })
```

Default: `null`

### <a name="input_containers"></a> [containers](#input\_containers)

Description: - `container_access_type` - (Optional) The Access Level configured for this Container. Possible values are `Blob`, `Container` or `None`. Defaults to `None`.
- `metadata` - (Optional) A mapping of MetaData for this Container. All metadata keys should be lowercase.
- `name` - (Required) The name of the Container which should be created within the Storage Account. Changing this forces a new resource to be created.

Supply role assignments in the same way as for `var.role_assignments`.

---
`timeouts` block supports the following:
- `create` - (Defaults to 30 minutes) Used when creating the Storage Container.
- `delete` - (Defaults to 30 minutes) Used when deleting the Storage Container.
- `read` - (Defaults to 5 minutes) Used when retrieving the Storage Container.
- `update` - (Defaults to 30 minutes) Used when updating the Storage Container.

Type:

```hcl
map(object({
    public_access                  = optional(string, "None")
    metadata                       = optional(map(string))
    name                           = string
    default_encryption_scope       = optional(string)
    deny_encryption_scope_override = optional(bool)
    enable_nfs_v3_all_squash       = optional(bool)
    enable_nfs_v3_root_squash      = optional(bool)
    immutable_storage_with_versioning = optional(object({
      enabled = bool
    }))

    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
    })), {})

    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
```

Default: `{}`

### <a name="input_cross_tenant_replication_enabled"></a> [cross\_tenant\_replication\_enabled](#input\_cross\_tenant\_replication\_enabled)

Description: (Optional) Should cross Tenant replication be enabled? Defaults to `false`.

Type: `bool`

Default: `false`

### <a name="input_custom_domain"></a> [custom\_domain](#input\_custom\_domain)

Description: - `name` - (Required) The Custom Domain Name to use for the Storage Account, which will be validated by Azure.
- `use_subdomain` - (Optional) Should the Custom Domain Name be validated by using indirect CNAME validation?

Type:

```hcl
object({
    name          = string
    use_subdomain = optional(bool)
  })
```

Default: `null`

### <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key)

Description:     Defines a customer managed key to use for encryption.

    object({  
      key\_vault\_resource\_id              = (Required) - The full Azure Resource ID of the key\_vault where the customer managed key will be referenced from.  
      key\_name                           = (Required) - The key name for the customer managed key in the key vault.  
      key\_version                        = (Optional) - The version of the key to use  
      user\_assigned\_identity\_resource\_id = (Optional) - The user assigned identity to use when access the key vault
    })

    Example Inputs:
    ```terraform
    customer_managed_key = {
      key_vault_resource_id = "/subscriptions/0000000-0000-0000-0000-000000000000/resourceGroups/test-resource-group/providers/Microsoft.KeyVault/vaults/example-key-vault"
      key_name              = "sample-customer-key"
    }
    
```

Type:

```hcl
object({
    key_vault_resource_id = string
    key_name              = string
    key_version           = optional(string, null)
    user_assigned_identity = optional(object({
      resource_id = string
    }), null)
  })
```

Default: `null`

### <a name="input_default_to_oauth_authentication"></a> [default\_to\_oauth\_authentication](#input\_default\_to\_oauth\_authentication)

Description: (Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is `false`

Type: `bool`

Default: `null`

### <a name="input_diagnostic_settings_blob"></a> [diagnostic\_settings\_blob](#input\_diagnostic\_settings\_blob)

Description: A map of diagnostic settings to create on the Blob Storage within Storage Account. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.
- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.
- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `["allLogs"]`.
- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.
- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.
- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.
- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.
- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.
- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.
- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs.

Type:

```hcl
map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), ["allLogs"])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
```

Default: `{}`

### <a name="input_diagnostic_settings_file"></a> [diagnostic\_settings\_file](#input\_diagnostic\_settings\_file)

Description: A map of diagnostic settings to create on the Azure Files Storage within Storage Account. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.
- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.
- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `["allLogs"]`.
- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.
- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.
- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.
- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.
- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.
- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.
- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs.

Type:

```hcl
map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), ["allLogs"])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
```

Default: `{}`

### <a name="input_diagnostic_settings_queue"></a> [diagnostic\_settings\_queue](#input\_diagnostic\_settings\_queue)

Description: A map of diagnostic settings to create on the Queue Storage within Storage Account. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.
- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.
- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `["allLogs"]`.
- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.
- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.
- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.
- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.
- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.
- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.
- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs.

Type:

```hcl
map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), ["allLogs"])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
```

Default: `{}`

### <a name="input_diagnostic_settings_storage_account"></a> [diagnostic\_settings\_storage\_account](#input\_diagnostic\_settings\_storage\_account)

Description: A map of diagnostic settings to create on the Storage Account. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.
- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.
- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `["allLogs"]`.
- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.
- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.
- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.
- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.
- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.
- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.
- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs.

Type:

```hcl
map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), ["allLogs"])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
```

Default: `{}`

### <a name="input_diagnostic_settings_table"></a> [diagnostic\_settings\_table](#input\_diagnostic\_settings\_table)

Description: A map of diagnostic settings to create on the Table Storage within the Storage Account. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.
- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.
- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `["allLogs"]`.
- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.
- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.
- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.
- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.
- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.
- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.
- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs.

Type:

```hcl
map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), ["allLogs"])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
```

Default: `{}`

### <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone)

Description: (Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist. Changing this forces a new Storage Account to be created.

Type: `string`

Default: `null`

### <a name="input_enable_telemetry"></a> [enable\_telemetry](#input\_enable\_telemetry)

Description: This variable controls whether or not telemetry is enabled for the module.  
For more information see https://aka.ms/avm/telemetryinfo.  
If it is set to false, then no telemetry will be collected.

Type: `bool`

Default: `true`

### <a name="input_https_traffic_only_enabled"></a> [https\_traffic\_only\_enabled](#input\_https\_traffic\_only\_enabled)

Description: (Optional) Boolean flag which forces HTTPS if enabled, see [here](https://docs.microsoft.com/azure/storage/storage-require-secure-transfer/) for more information. Defaults to `true`.

Type: `bool`

Default: `true`

### <a name="input_immutability_policy"></a> [immutability\_policy](#input\_immutability\_policy)

Description: - `allow_protected_append_writes` - (Required) When enabled, new blocks can be written to an append blob while maintaining immutability protection and compliance. Only new blocks can be added and any existing blocks cannot be modified or deleted.
- `period_since_creation_in_days` - (Required) The immutability period for the blobs in the container since the policy creation, in days.
- `state` - (Required) Defines the mode of the policy. `Disabled` state disables the policy, `Unlocked` state allows increase and decrease of immutability retention time and also allows toggling allowProtectedAppendWrites property, `Locked` state only allows the increase of the immutability retention time. A policy can only be created in a Disabled or Unlocked state and can be toggled between the two states. Only a policy in an Unlocked state can transition to a Locked state which cannot be reverted.

Type:

```hcl
object({
    allow_protected_append_writes = bool
    period_since_creation_in_days = number
    state                         = string
  })
```

Default: `null`

### <a name="input_infrastructure_encryption_enabled"></a> [infrastructure\_encryption\_enabled](#input\_infrastructure\_encryption\_enabled)

Description: (Optional) Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to `false`.

Type: `bool`

Default: `false`

### <a name="input_is_hns_enabled"></a> [is\_hns\_enabled](#input\_is\_hns\_enabled)

Description: (Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 ([see here for more information](https://docs.microsoft.com/azure/storage/blobs/data-lake-storage-quickstart-create-account/)). Changing this forces a new resource to be created.

Type: `bool`

Default: `null`

### <a name="input_large_file_share_enabled"></a> [large\_file\_share\_enabled](#input\_large\_file\_share\_enabled)

Description: (Optional) Is Large File Share Enabled?

Type: `bool`

Default: `null`

### <a name="input_local_user"></a> [local\_user](#input\_local\_user)

Description: - `home_directory` - (Optional) The home directory of the Storage Account Local User.
- `name` - (Required) The name which should be used for this Storage Account Local User. Changing this forces a new Storage Account Local User to be created.
- `ssh_key_enabled` - (Optional) Specifies whether SSH Key Authentication is enabled. Defaults to `false`.
- `ssh_password_enabled` - (Optional) Specifies whether SSH Password Authentication is enabled. Defaults to `false`.

---
`permission_scope` block supports the following:
- `resource_name` - (Required) The container name (when `service` is set to `blob`) or the file share name (when `service` is set to `file`), used by the Storage Account Local User.
- `service` - (Required) The storage service used by this Storage Account Local User. Possible values are `blob` and `file`.

---
`permissions` block supports the following:
- `create` - (Optional) Specifies if the Local User has the create permission for this scope. Defaults to `false`.
- `delete` - (Optional) Specifies if the Local User has the delete permission for this scope. Defaults to `false`.
- `list` - (Optional) Specifies if the Local User has the list permission for this scope. Defaults to `false`.
- `read` - (Optional) Specifies if the Local User has the read permission for this scope. Defaults to `false`.
- `write` - (Optional) Specifies if the Local User has the write permission for this scope. Defaults to `false`.

---
`ssh_authorized_key` block supports the following:
- `description` - (Optional) The description of this SSH authorized key.
- `key` - (Required) The public key value of this SSH authorized key.

---
`timeouts` block supports the following:
- `create` - (Defaults to 30 minutes) Used when creating the Storage Account Local User.
- `delete` - (Defaults to 30 minutes) Used when deleting the Storage Account Local User.
- `read` - (Defaults to 5 minutes) Used when retrieving the Storage Account Local User.
- `update` - (Defaults to 30 minutes) Used when updating the Storage Account Local User.

Type:

```hcl
map(object({
    home_directory       = optional(string)
    name                 = string
    ssh_key_enabled      = optional(bool)
    ssh_password_enabled = optional(bool)
    permission_scope = optional(list(object({
      resource_name = string
      service       = string
      permissions = object({
        create = optional(bool)
        delete = optional(bool)
        list   = optional(bool)
        read   = optional(bool)
        write  = optional(bool)
      })
    })))
    ssh_authorized_key = optional(list(object({
      description = optional(string)
      key         = string
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
```

Default: `{}`

### <a name="input_lock"></a> [lock](#input\_lock)

Description: The lock level to apply. Default is `None`. Possible values are `None`, `CanNotDelete`, and `ReadOnly`.

Type:

```hcl
object({
    name = optional(string, null)
    kind = string
  })
```

Default: `null`

### <a name="input_managed_identities"></a> [managed\_identities](#input\_managed\_identities)

Description:   Controls the Managed Identity configuration on this resource. The following properties can be specified:

  - `system_assigned` - (Optional) Specifies if the System Assigned Managed Identity should be enabled.
  - `user_assigned_resource_ids` - (Optional) Specifies a list of User Assigned Managed Identity resource IDs to be assigned to this resource.

Type:

```hcl
object({
    system_assigned            = optional(bool, false)
    user_assigned_resource_ids = optional(set(string), [])
  })
```

Default: `{}`

### <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version)

Description: (Optional) The minimum supported TLS version for the storage account. Possible values are `TLS1_0`, `TLS1_1`, and `TLS1_2`. Defaults to `TLS1_2` for new storage accounts.

Type: `string`

Default: `"TLS1_2"`

### <a name="input_network_rules"></a> [network\_rules](#input\_network\_rules)

Description: > Note the default value for this variable will block all public access to the storage account. If you want to disable all network rules, set this value to `null`.

- `bypass` - (Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of `Logging`, `Metrics`, `AzureServices`, or `None`.
- `default_action` - (Required) Specifies the default action of allow or deny when no other rules match. Valid options are `Deny` or `Allow`.
- `ip_rules` - (Optional) List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. Private IP address ranges (as defined in [RFC 1918](https://tools.ietf.org/html/rfc1918#section-3)) are not allowed.
- `storage_account_id` - (Required) Specifies the ID of the storage account. Changing this forces a new resource to be created.
- `virtual_network_subnet_ids` - (Optional) A list of virtual network subnet ids to secure the storage account.

---
`private_link_access` block supports the following:
- `endpoint_resource_id` - (Required) The resource id of the resource access rule to be granted access.
- `endpoint_tenant_id` - (Optional) The tenant id of the resource of the resource access rule to be granted access. Defaults to the current tenant id.

---
`timeouts` block supports the following:
- `create` - (Defaults to 60 minutes) Used when creating the  Network Rules for this Storage Account.
- `delete` - (Defaults to 60 minutes) Used when deleting the Network Rules for this Storage Account.
- `read` - (Defaults to 5 minutes) Used when retrieving the Network Rules for this Storage Account.
- `update` - (Defaults to 60 minutes) Used when updating the Network Rules for this Storage Account.

Type:

```hcl
object({
    bypass                     = optional(set(string), ["AzureServices"])
    default_action             = optional(string, "Deny")
    ip_rules                   = optional(set(string), [])
    virtual_network_subnet_ids = optional(set(string), [])
    private_link_access = optional(list(object({
      endpoint_resource_id = string
      endpoint_tenant_id   = optional(string)
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  })
```

Default: `{}`

### <a name="input_nfsv3_enabled"></a> [nfsv3\_enabled](#input\_nfsv3\_enabled)

Description: (Optional) Is NFSv3 protocol enabled? Changing this forces a new resource to be created. Defaults to `false`.

Type: `bool`

Default: `false`

### <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints)

Description: A map of private endpoints to create on the resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `name` - (Optional) The name of the private endpoint. One will be generated if not set.
- `role_assignments` - (Optional) A map of role assignments to create on the private endpoint. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time. See `var.role_assignments` for more information.
- `lock` - (Optional) The lock level to apply to the private endpoint. Default is `None`. Possible values are `None`, `CanNotDelete`, and `ReadOnly`.
- `tags` - (Optional) A mapping of tags to assign to the private endpoint.
- `subnet_resource_id` - The resource ID of the subnet to deploy the private endpoint in.
- `subresource_name` - The service name of the private endpoint.  Possible value are `blob`, 'dfs', 'file', `queue`, `table`, and `web`.
- `private_dns_zone_group_name` - (Optional) The name of the private DNS zone group. One will be generated if not set.
- `private_dns_zone_resource_ids` - (Optional) A set of resource IDs of private DNS zones to associate with the private endpoint. If not set, no zone groups will be created and the private endpoint will not be associated with any private DNS zones. DNS records must be managed external to this module.
- `application_security_group_resource_ids` - (Optional) A map of resource IDs of application security groups to associate with the private endpoint. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
- `private_service_connection_name` - (Optional) The name of the private service connection. One will be generated if not set.
- `network_interface_name` - (Optional) The name of the network interface. One will be generated if not set.
- `location` - (Optional) The Azure location where the resources will be deployed. Defaults to the location of the resource group.
- `resource_group_name` - (Optional) The resource group where the resources will be deployed. Defaults to the resource group of the resource.
- `ip_configurations` - (Optional) A map of IP configurations to create on the private endpoint. If not specified the platform will create one. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
  - `name` - The name of the IP configuration.
  - `private_ip_address` - The private IP address of the IP configuration.

Type:

```hcl
map(object({
    name = optional(string, null)
    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
      principal_type                         = optional(string, null)
    })), {})
    lock = optional(object({
      kind = string
      name = optional(string, null)
    }), null)
    tags                                    = optional(map(string), null)
    subnet_resource_id                      = string
    subresource_name                        = string
    private_dns_zone_group_name             = optional(string, "default")
    private_dns_zone_resource_ids           = optional(set(string), [])
    application_security_group_associations = optional(map(string), {})
    private_service_connection_name         = optional(string, null)
    network_interface_name                  = optional(string, null)
    location                                = optional(string, null)
    resource_group_name                     = optional(string, null)
    ip_configurations = optional(map(object({
      name               = string
      private_ip_address = string
    })), {})
  }))
```

Default: `{}`

### <a name="input_private_endpoints_manage_dns_zone_group"></a> [private\_endpoints\_manage\_dns\_zone\_group](#input\_private\_endpoints\_manage\_dns\_zone\_group)

Description: Whether to manage private DNS zone groups with this module. If set to false, you must manage private DNS zone groups externally, e.g. using Azure Policy.

Type: `bool`

Default: `true`

### <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled)

Description: (Optional) Whether the public network access is enabled? Defaults to `false`.

Type: `bool`

Default: `false`

### <a name="input_queue_encryption_key_type"></a> [queue\_encryption\_key\_type](#input\_queue\_encryption\_key\_type)

Description: (Optional) The encryption type of the queue service. Possible values are `Service` and `Account`. Changing this forces a new resource to be created. Default value is `Service`.

Type: `string`

Default: `null`

### <a name="input_queue_properties"></a> [queue\_properties](#input\_queue\_properties)

Description:
---
`cors_rule` block supports the following:
- `allowed_headers` - (Required) A list of headers that are allowed to be a part of the cross-origin request.
- `allowed_methods` - (Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are `DELETE`, `GET`, `HEAD`, `MERGE`, `POST`, `OPTIONS`, `PUT` or `PATCH`.
- `allowed_origins` - (Required) A list of origin domains that will be allowed by CORS.
- `exposed_headers` - (Required) A list of response headers that are exposed to CORS clients.
- `max_age_in_seconds` - (Required) The number of seconds the client should cache a preflight response.

---
`diagnostic_settings` block supports the following:
- `name` - (Optional) The name of the diagnostic setting. Defaults to `null`.
- `log_categories` - (Optional) A set of log categories to enable. Defaults to an empty set.
- `log_groups` - (Optional) A set of log groups to enable. Defaults to `["allLogs"]`.
- `metric_categories` - (Optional) A set of metric categories to enable. Defaults to `["AllMetrics"]`.
- `log_analytics_destination_type` - (Optional) The destination type for log analytics. Defaults to `"Dedicated"`.
- `workspace_resource_id` - (Optional) The resource ID of the Log Analytics workspace. Defaults to `null`.
- `resource_id` - (Optional) The resource ID of the target resource for diagnostics. Defaults to `null`.
- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the Event Hub authorization rule. Defaults to `null`.
- `event_hub_name` - (Optional) The name of the Event Hub. Defaults to `null`.
- `marketplace_partner_resource_id` - (Optional) The resource ID of the marketplace partner. Defaults to `null`.

---
`hour_metrics` block supports the following:
- `enabled` - (Required) Indicates whether hour metrics are enabled for the Queue service.
- `include_apis` - (Optional) Indicates whether metrics should generate summary statistics for called API operations.
- `retention_policy_days` - (Optional) Specifies the number of days that logs will be retained.
- `version` - (Required) The version of storage analytics to configure.

---
`logging` block supports the following:
- `delete` - (Required) Indicates whether all delete requests should be logged.
- `read` - (Required) Indicates whether all read requests should be logged.
- `retention_policy_days` - (Optional) Specifies the number of days that logs will be retained.
- `version` - (Required) The version of storage analytics to configure.
- `write` - (Required) Indicates whether all write requests should be logged.

---
`minute_metrics` block supports the following:
- `enabled` - (Required) Indicates whether minute metrics are enabled for the Queue service.
- `include_apis` - (Optional) Indicates whether metrics should generate summary statistics for called API operations.
- `retention_policy_days` - (Optional) Specifies the number of days that logs will be retained.
- `version` - (Required) The version of storage analytics to configure.

Type:

```hcl
object({
    cors_rule = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })))
    diagnostic_settings = optional(map(object({
      name                                     = optional(string, null)
      log_categories                           = optional(set(string), [])
      log_groups                               = optional(set(string), ["allLogs"])
      metric_categories                        = optional(set(string), ["AllMetrics"])
      log_analytics_destination_type           = optional(string, "Dedicated")
      workspace_resource_id                    = optional(string, null)
      resource_id                              = optional(string, null)
      event_hub_authorization_rule_resource_id = optional(string, null)
      event_hub_name                           = optional(string, null)
      marketplace_partner_resource_id          = optional(string, null)
    })), {})
    hour_metrics = optional(object({
      enabled               = bool
      include_apis          = optional(bool)
      retention_policy_days = optional(number)
      version               = string
    }))
    logging = optional(object({
      delete                = bool
      read                  = bool
      retention_policy_days = optional(number)
      version               = string
      write                 = bool
    }))
    minute_metrics = optional(object({
      enabled               = bool
      include_apis          = optional(bool)
      retention_policy_days = optional(number)
      version               = string
    }))
  })
```

Default: `null`

### <a name="input_queues"></a> [queues](#input\_queues)

Description:  - `metadata` - (Optional) A mapping of MetaData which should be assigned to this Storage Queue.
 - `name` - (Required) The name of the Queue which should be created within the Storage Account. Must be unique within the storage account the queue is located. Changing this forces a new resource to be created.

Supply role assignments in the same way as for `var.role_assignments`.

 ---
 `timeouts` block supports the following:
 - `create` - (Defaults to 30 minutes) Used when creating the Storage Queue.
 - `delete` - (Defaults to 30 minutes) Used when deleting the Storage Queue.
 - `read` - (Defaults to 5 minutes) Used when retrieving the Storage Queue.
 - `update` - (Defaults to 30 minutes) Used when updating the Storage Queue.

Type:

```hcl
map(object({
    metadata = optional(map(string))
    name     = string
    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
    })), {})
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
```

Default: `{}`

### <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments)

Description: A map of role assignments to create on the resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.
- `principal_id` - The ID of the principal to assign the role to.
- `description` - The description of the role assignment.
- `skip_service_principal_aad_check` - If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.
- `condition` - The condition which will be used to scope the role assignment.
- `condition_version` - The version of the condition syntax. Valid values are '2.0'.

> Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.

Type:

```hcl
map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
  }))
```

Default: `{}`

### <a name="input_routing"></a> [routing](#input\_routing)

Description: - `choice` - (Optional) Specifies the kind of network routing opted by the user. Possible values are `InternetRouting` and `MicrosoftRouting`. Defaults to `MicrosoftRouting`.
- `publish_internet_endpoints` - (Optional) Should internet routing storage endpoints be published? Defaults to `false`.
- `publish_microsoft_endpoints` - (Optional) Should Microsoft routing storage endpoints be published? Defaults to `false`.

Type:

```hcl
object({
    choice                      = optional(string, "MicrosoftRouting")
    publish_internet_endpoints  = optional(bool, false)
    publish_microsoft_endpoints = optional(bool, false)
  })
```

Default: `null`

### <a name="input_sas_policy"></a> [sas\_policy](#input\_sas\_policy)

Description: - `expiration_action` - (Optional) The SAS expiration action. The only possible value is `Log` at this moment. Defaults to `Log`.
- `expiration_period` - (Required) The SAS expiration period in format of `DD.HH:MM:SS`.

Type:

```hcl
object({
    expiration_action = optional(string, "Log")
    expiration_period = string
  })
```

Default: `null`

### <a name="input_sftp_enabled"></a> [sftp\_enabled](#input\_sftp\_enabled)

Description: (Optional) Boolean, enable SFTP for the storage account.  Defaults to `false`.

Type: `bool`

Default: `false`

### <a name="input_share_properties"></a> [share\_properties](#input\_share\_properties)

Description:
---
`cors_rule` block supports the following:
- `allowed_headers` - (Required) A list of headers that are allowed to be a part of the cross-origin request.
- `allowed_methods` - (Required) A list of HTTP methods that are allowed to be executed by the origin. Valid options are `DELETE`, `GET`, `HEAD`, `MERGE`, `POST`, `OPTIONS`, `PUT` or `PATCH`.
- `allowed_origins` - (Required) A list of origin domains that will be allowed by CORS.
- `exposed_headers` - (Required) A list of response headers that are exposed to CORS clients.
- `max_age_in_seconds` - (Required) The number of seconds the client should cache a preflight response.

---
`diagnostic_settings` block supports the following:
- `name` - (Optional) The name of the diagnostic setting. Defaults to `null`.
- `log_categories` - (Optional) A set of log categories to enable. Defaults to an empty set.
- `log_groups` - (Optional) A set of log groups to enable. Defaults to `["allLogs"]`.
- `metric_categories` - (Optional) A set of metric categories to enable. Defaults to `["AllMetrics"]`.
- `log_analytics_destination_type` - (Optional) The destination type for log analytics. Defaults to `"Dedicated"`.
- `workspace_resource_id` - (Optional) The resource ID of the Log Analytics workspace. Defaults to `null`.
- `resource_id` - (Optional) The resource ID of the target resource for diagnostics. Defaults to `null`.
- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the Event Hub authorization rule. Defaults to `null`.
- `event_hub_name` - (Optional) The name of the Event Hub. Defaults to `null`.
- `marketplace_partner_resource_id` - (Optional) The resource ID of the marketplace partner. Defaults to `null`.

---
`retention_policy` block supports the following:
- `days` - (Optional) Specifies the number of days that the `azurerm_shares` should be retained, between `1` and `365` days. Defaults to `7`.

---
`smb` block supports the following:
- `authentication_types` - (Optional) A set of SMB authentication methods. Possible values are `NTLMv2`, and `Kerberos`.
- `channel_encryption_type` - (Optional) A set of SMB channel encryption. Possible values are `AES-128-CCM`, `AES-128-GCM`, and `AES-256-GCM`.
- `kerberos_ticket_encryption_type` - (Optional) A set of Kerberos ticket encryption. Possible values are `RC4-HMAC`, and `AES-256`.
- `multichannel_enabled` - (Optional) Indicates whether multichannel is enabled. Defaults to `false`. This is only supported on Premium storage accounts.
- `versions` - (Optional) A set of SMB protocol versions. Possible values are `SMB2.1`, `SMB3.0`, and `SMB3.1.1`.

Type:

```hcl
object({
    cors_rule = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })))
    diagnostic_settings = optional(map(object({
      name                                     = optional(string, null)
      log_categories                           = optional(set(string), [])
      log_groups                               = optional(set(string), ["allLogs"])
      metric_categories                        = optional(set(string), ["AllMetrics"])
      log_analytics_destination_type           = optional(string, "Dedicated")
      workspace_resource_id                    = optional(string, null)
      resource_id                              = optional(string, null)
      event_hub_authorization_rule_resource_id = optional(string, null)
      event_hub_name                           = optional(string, null)
      marketplace_partner_resource_id          = optional(string, null)
    })), {})
    retention_policy = optional(object({
      days = optional(number)
    }))
    smb = optional(object({
      authentication_types            = optional(set(string))
      channel_encryption_type         = optional(set(string))
      kerberos_ticket_encryption_type = optional(set(string))
      multichannel_enabled            = optional(bool)
      versions                        = optional(set(string))
    }))
  })
```

Default: `null`

### <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled)

Description: (Optional) Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is `false`.

Type: `bool`

Default: `false`

### <a name="input_shares"></a> [shares](#input\_shares)

Description:  - `access_tier` - (Optional) The access tier of the File Share. Possible values are `Hot`, `Cool` and `TransactionOptimized`, `Premium`.
 - `enabled_protocol` - (Optional) The protocol used for the share. Possible values are `SMB` and `NFS`. The `SMB` indicates the share can be accessed by SMBv3.0, SMBv2.1 and REST. The `NFS` indicates the share can be accessed by NFSv4.1. Defaults to `SMB`. Changing this forces a new resource to be created.
 - `metadata` - (Optional) A mapping of MetaData for this File Share.
 - `name` - (Required) The name of the share. Must be unique within the storage account where the share is located. Changing this forces a new resource to be created.
 - `quota` - (Required) The maximum size of the share, in gigabytes. For Standard storage accounts, this must be `1`GB (or higher) and at most `5120` GB (`5` TB). For Premium FileStorage storage accounts, this must be greater than 100 GB and at most `102400` GB (`100` TB).

 ---
 `acl` block supports the following:
 - `id` - (Required) The ID which should be used for this Shared Identifier.

 ---
 `access_policy` block supports the following:
 - `expiry` - (Optional) The time at which this Access Policy should be valid until, in [ISO8601](https://en.wikipedia.org/wiki/ISO_8601) format.
 - `permissions` - (Required) The permissions which should be associated with this Shared Identifier. Possible value is combination of `r` (read), `w` (write), `d` (delete), and `l` (list).
 - `start` - (Optional) The time at which this Access Policy should be valid from, in [ISO8601](https://en.wikipedia.org/wiki/ISO_8601) format.

 ---
 `timeouts` block supports the following:
 - `create` - (Defaults to 30 minutes) Used when creating the Storage Share.
 - `delete` - (Defaults to 30 minutes) Used when deleting the Storage Share.
 - `read` - (Defaults to 5 minutes) Used when retrieving the Storage Share.
 - `update` - (Defaults to 30 minutes) Used when updating the Storage Share.

 ---
 `directories` block supports the following:
 - `name` - The name (or path) of the Directory that should be created within this File Share. Changing this forces a new resource to be created.
 - `metadata` - A mapping of metadata to assign to this Directory.

Supply role assignments in the same way as for `var.role_assignments`.

Type:

```hcl
map(object({
    access_tier      = optional(string)
    enabled_protocol = optional(string)
    metadata         = optional(map(string))
    name             = string
    quota            = number
    root_squash      = optional(string)
    signed_identifiers = optional(list(object({
      id = string
      access_policy = optional(object({
        expiry_time = string
        permission  = string
        start_time  = string
      }))
    })))
    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
    })), {})
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
    directories = optional(list(object({
      name     = string
      metadata = optional(map(string))
    })), [])
  }))
```

Default: `{}`

### <a name="input_static_website"></a> [static\_website](#input\_static\_website)

Description: - `error_404_document` - (Optional) The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file.
- `index_document` - (Optional) The webpage that Azure Storage serves for requests to the root of a website or any subfolder. For example, index.html. The value is case-sensitive.

Type:

```hcl
object({
    error_404_document = optional(string)
    index_document     = optional(string)
  })
```

Default: `null`

### <a name="input_storage_data_lake_gen2_filesystem"></a> [storage\_data\_lake\_gen2\_filesystem](#input\_storage\_data\_lake\_gen2\_filesystem)

Description: - `default_encryption_scope` - (Optional) The default encryption scope to use for this filesystem. Changing this forces a new resource to be created.
- `group` - (Optional) Specifies the Object ID of the Azure Active Directory Group to make the owning group of the root path (i.e. `/`). Possible values also include `$superuser`.
- `name` - (Required) The name of the Data Lake Gen2 File System which should be created within the Storage Account. Must be unique within the storage account the queue is located. Changing this forces a new resource to be created.
- `owner` - (Optional) Specifies the Object ID of the Azure Active Directory User to make the owning user of the root path (i.e. `/`). Possible values also include `$superuser`.
- `properties` - (Optional) A mapping of Key to Base64-Encoded Values which should be assigned to this Data Lake Gen2 File System.
---
`ace` block supports the following:
- `id` - (Optional) Specifies the Object ID of the Azure Active Directory User or Group that the entry relates to. Only valid for `user` or `group` entries.
- `permissions` - (Required) Specifies the permissions for the entry in `rwx` form. For example, `rwx` gives full permissions but `r--` only gives read permissions.
- `scope` - (Optional) Specifies whether the ACE represents an `access` entry or a `default` entry. Default value is `access`.
- `type` - (Required) Specifies the type of entry. Can be `user`, `group`, `mask` or `other`.

---
`timeouts` block supports the following:
- `create` - (Defaults to 30 minutes) Used when creating the Data Lake Gen2 File System.
- `delete` - (Defaults to 30 minutes) Used when deleting the Data Lake Gen2 File System.
- `read` - (Defaults to 5 minutes) Used when retrieving the Data Lake Gen2 File System.
- `update` - (Defaults to 30 minutes) Used when updating the Data Lake Gen2 File System.

Type:

```hcl
object({
    default_encryption_scope = optional(string)
    group                    = optional(string)
    name                     = string
    owner                    = optional(string)
    properties               = optional(map(string))
    ace = optional(set(object({
      id          = optional(string)
      permissions = string
      scope       = optional(string)
      type        = string
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  })
```

Default: `null`

### <a name="input_storage_management_policy_rule"></a> [storage\_management\_policy\_rule](#input\_storage\_management\_policy\_rule)

Description: - `enabled` - (Required) Boolean to specify whether the rule is enabled.
- `name` - (Required) The name of the rule. Rule name is case-sensitive. It must be unique within a policy.

---
`actions` block supports the following:

---
`base_blob` block supports the following:
- `auto_tier_to_hot_from_cool_enabled` - (Optional) Whether a blob should automatically be tiered from cool back to hot if it's accessed again after being tiered to cool. Defaults to `false`.
- `delete_after_days_since_creation_greater_than` - (Optional) The age in days after creation to delete the blob. Must be between `0` and `99999`. Defaults to `-1`.
- `delete_after_days_since_last_access_time_greater_than` - (Optional) The age in days after last access time to delete the blob. Must be between `0` and `99999`. Defaults to `-1`.
- `delete_after_days_since_modification_greater_than` - (Optional) The age in days after last modification to delete the blob. Must be between 0 and 99999. Defaults to `-1`.
- `tier_to_archive_after_days_since_creation_greater_than` - (Optional) The age in days after creation to archive storage. Supports blob currently at Hot or Cool tier. Must be between `0` and`99999`. Defaults to `-1`.
- `tier_to_archive_after_days_since_last_access_time_greater_than` - (Optional) The age in days after last access time to tier blobs to archive storage. Supports blob currently at Hot or Cool tier. Must be between `0` and`99999`. Defaults to `-1`.
- `tier_to_archive_after_days_since_last_tier_change_greater_than` - (Optional) The age in days after last tier change to the blobs to skip to be archved. Must be between 0 and 99999. Defaults to `-1`.
- `tier_to_archive_after_days_since_modification_greater_than` - (Optional) The age in days after last modification to tier blobs to archive storage. Supports blob currently at Hot or Cool tier. Must be between 0 and 99999. Defaults to `-1`.
- `tier_to_cold_after_days_since_creation_greater_than` - (Optional) The age in days after creation to cold storage. Supports blob currently at Hot tier. Must be between `0` and `99999`. Defaults to `-1`.
- `tier_to_cold_after_days_since_last_access_time_greater_than` - (Optional) The age in days after last access time to tier blobs to cold storage. Supports blob currently at Hot tier. Must be between `0` and `99999`. Defaults to `-1`.
- `tier_to_cold_after_days_since_modification_greater_than` - (Optional) The age in days after last modification to tier blobs to cold storage. Supports blob currently at Hot tier. Must be between 0 and 99999. Defaults to `-1`.
- `tier_to_cool_after_days_since_creation_greater_than` - (Optional) The age in days after creation to cool storage. Supports blob currently at Hot tier. Must be between `0` and `99999`. Defaults to `-1`.
- `tier_to_cool_after_days_since_last_access_time_greater_than` - (Optional) The age in days after last access time to tier blobs to cool storage. Supports blob currently at Hot tier. Must be between `0` and `99999`. Defaults to `-1`.
- `tier_to_cool_after_days_since_modification_greater_than` - (Optional) The age in days after last modification to tier blobs to cool storage. Supports blob currently at Hot tier. Must be between 0 and 99999. Defaults to `-1`.

---
`snapshot` block supports the following:
- `change_tier_to_archive_after_days_since_creation` - (Optional) The age in days after creation to tier blob snapshot to archive storage. Must be between 0 and 99999. Defaults to `-1`.
- `change_tier_to_cool_after_days_since_creation` - (Optional) The age in days after creation to tier blob snapshot to cool storage. Must be between 0 and 99999. Defaults to `-1`.
- `delete_after_days_since_creation_greater_than` - (Optional) The age in days after creation to delete the blob snapshot. Must be between 0 and 99999. Defaults to `-1`.
- `tier_to_archive_after_days_since_last_tier_change_greater_than` - (Optional) The age in days after last tier change to the blobs to skip to be archved. Must be between 0 and 99999. Defaults to `-1`.
- `tier_to_cold_after_days_since_creation_greater_than` - (Optional) The age in days after creation to cold storage. Supports blob currently at Hot tier. Must be between `0` and `99999`. Defaults to `-1`.

---
`version` block supports the following:
- `change_tier_to_archive_after_days_since_creation` - (Optional) The age in days after creation to tier blob version to archive storage. Must be between 0 and 99999. Defaults to `-1`.
- `change_tier_to_cool_after_days_since_creation` - (Optional) The age in days creation create to tier blob version to cool storage. Must be between 0 and 99999. Defaults to `-1`.
- `delete_after_days_since_creation` - (Optional) The age in days after creation to delete the blob version. Must be between 0 and 99999. Defaults to `-1`.
- `tier_to_archive_after_days_since_last_tier_change_greater_than` - (Optional) The age in days after last tier change to the blobs to skip to be archved. Must be between 0 and 99999. Defaults to `-1`.
- `tier_to_cold_after_days_since_creation_greater_than` - (Optional) The age in days after creation to cold storage. Supports blob currently at Hot tier. Must be between `0` and `99999`. Defaults to `-1`.

---
`filters` block supports the following:
- `blob_types` - (Required) An array of predefined values. Valid options are `blockBlob` and `appendBlob`.
- `prefix_match` - (Optional) An array of strings for prefixes to be matched.

---
`match_blob_index_tag` block supports the following:
- `name` - (Required) The filter tag name used for tag based filtering for blob objects.
- `operation` - (Optional) The comparison operator which is used for object comparison and filtering. Possible value is `==`. Defaults to `==`.
- `value` - (Required) The filter tag value used for tag based filtering for blob objects.

Type:

```hcl
map(object({
    enabled = bool
    name    = string
    actions = object({
      base_blob = optional(object({
        auto_tier_to_hot_from_cool_enabled                             = optional(bool)
        delete_after_days_since_creation_greater_than                  = optional(number)
        delete_after_days_since_last_access_time_greater_than          = optional(number)
        delete_after_days_since_modification_greater_than              = optional(number)
        tier_to_archive_after_days_since_creation_greater_than         = optional(number)
        tier_to_archive_after_days_since_last_access_time_greater_than = optional(number)
        tier_to_archive_after_days_since_last_tier_change_greater_than = optional(number)
        tier_to_archive_after_days_since_modification_greater_than     = optional(number)
        tier_to_cold_after_days_since_creation_greater_than            = optional(number)
        tier_to_cold_after_days_since_last_access_time_greater_than    = optional(number)
        tier_to_cold_after_days_since_modification_greater_than        = optional(number)
        tier_to_cool_after_days_since_creation_greater_than            = optional(number)
        tier_to_cool_after_days_since_last_access_time_greater_than    = optional(number)
        tier_to_cool_after_days_since_modification_greater_than        = optional(number)
      }))
      snapshot = optional(object({
        change_tier_to_archive_after_days_since_creation               = optional(number)
        change_tier_to_cool_after_days_since_creation                  = optional(number)
        delete_after_days_since_creation_greater_than                  = optional(number)
        tier_to_archive_after_days_since_last_tier_change_greater_than = optional(number)
        tier_to_cold_after_days_since_creation_greater_than            = optional(number)
      }))
      version = optional(object({
        change_tier_to_archive_after_days_since_creation               = optional(number)
        change_tier_to_cool_after_days_since_creation                  = optional(number)
        delete_after_days_since_creation                               = optional(number)
        tier_to_archive_after_days_since_last_tier_change_greater_than = optional(number)
        tier_to_cold_after_days_since_creation_greater_than            = optional(number)
      }))
    })
    filters = object({
      blob_types   = set(string)
      prefix_match = optional(set(string))
      match_blob_index_tag = optional(set(object({
        name      = string
        operation = optional(string)
        value     = string
      })))
    })
  }))
```

Default: `{}`

### <a name="input_storage_management_policy_timeouts"></a> [storage\_management\_policy\_timeouts](#input\_storage\_management\_policy\_timeouts)

Description: - `create` - (Defaults to 30 minutes) Used when creating the Storage Account Management Policy.
- `delete` - (Defaults to 30 minutes) Used when deleting the Storage Account Management Policy.
- `read` - (Defaults to 5 minutes) Used when retrieving the Storage Account Management Policy.
- `update` - (Defaults to 30 minutes) Used when updating the Storage Account Management Policy.

Type:

```hcl
object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
```

Default: `null`

### <a name="input_table_encryption_key_type"></a> [table\_encryption\_key\_type](#input\_table\_encryption\_key\_type)

Description: (Optional) The encryption type of the table service. Possible values are `Service` and `Account`. Changing this forces a new resource to be created. Default value is `Service`.

Type: `string`

Default: `null`

### <a name="input_tables"></a> [tables](#input\_tables)

Description:  - `name` - (Required) The name of the storage table. Only Alphanumeric characters allowed, starting with a letter. Must be unique within the storage account the table is located. Changing this forces a new resource to be created.

 ---
 `acl` block supports the following:
 - `id` - (Required) The ID which should be used for this Shared Identifier.

 ---
 `access_policy` block supports the following:
 - `expiry` - (Required) The ISO8061 UTC time at which this Access Policy should be valid until.
 - `permissions` - (Required) The permissions which should associated with this Shared Identifier.
 - `start` - (Required) The ISO8061 UTC time at which this Access Policy should be valid from.

 ---
 `timeouts` block supports the following:
 - `create` - (Defaults to 30 minutes) Used when creating the Storage Table.
 - `delete` - (Defaults to 30 minutes) Used when deleting the Storage Table.
 - `read` - (Defaults to 5 minutes) Used when retrieving the Storage Table.
 - `update` - (Defaults to 30 minutes) Used when updating the Storage Table.

Supply role assignments in the same way as for `var.role_assignments`.

Type:

```hcl
map(object({
    name = string
    signed_identifiers = optional(list(object({
      id = string
      access_policy = optional(object({
        expiry_time = string
        permission  = string
        start_time  = string
      }))
    })))

    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
    })), {})

    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
```

Default: `{}`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: Custom tags to apply to the resource.

Type: `map(string)`

Default: `null`

### <a name="input_timeouts"></a> [timeouts](#input\_timeouts)

Description: - `create` - (Defaults to 60 minutes) Used when creating the Storage Account.
- `delete` - (Defaults to 60 minutes) Used when deleting the Storage Account.
- `read` - (Defaults to 5 minutes) Used when retrieving the Storage Account.
- `update` - (Defaults to 60 minutes) Used when updating the Storage Account.

Type:

```hcl
object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
```

Default: `null`

## Outputs

The following outputs are exported:

### <a name="output_containers"></a> [containers](#output\_containers)

Description: Map of storage containers that are created.

### <a name="output_fqdn"></a> [fqdn](#output\_fqdn)

Description: Fqdns for storage services.

### <a name="output_name"></a> [name](#output\_name)

Description: The name of the storage account

### <a name="output_private_endpoints"></a> [private\_endpoints](#output\_private\_endpoints)

Description: A map of private endpoints. The map key is the supplied input to var.private\_endpoints. The map value is the entire azurerm\_private\_endpoint resource.

### <a name="output_queues"></a> [queues](#output\_queues)

Description: Map of storage queues that are created.

### <a name="output_resource"></a> [resource](#output\_resource)

Description: This is the full resource output for the Storage Account resource.

### <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id)

Description: The ID of the Storage Account.

### <a name="output_shares"></a> [shares](#output\_shares)

Description: Map of storage storage shares that are created.

### <a name="output_tables"></a> [tables](#output\_tables)

Description: Map of storage tables that are created.

## Modules

No modules.

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->