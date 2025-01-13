data "azurerm_client_config" "example" {

}

resource "random_string" "keyvault_suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_key_vault" "storage-keyvault" {
  name                = "storage-keyvault-${random_string.keyvault_suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.example.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.example.tenant_id
    object_id = data.azurerm_client_config.example.object_id

    secret_permissions = [
      "Get",
      "Delete",
      "List",

    ]

    key_permissions = [ # Added key permissions here
      "Get",
      "List", # Allows listing keys
      "Create",
      "Delete",
      "Encrypt",
      "Decrypt",
      "Sign",
      "Verify",
      "WrapKey",
      "UnwrapKey",
      "Purge",
    ]

    storage_permissions = [
      "Get",
      "List",
      "Set",
      "SetSAS",
      "GetSAS",
      "DeleteSAS",
      "Update",
      "RegenerateKey",
      "Recover",
      "Backup",
      "Purge",
      "Restore"

    ]
  }
}

resource "azurerm_key_vault_managed_storage_account" "storage-keyvault-managed-storage-account" {
  name               = "storagemanagedstorage"
  key_vault_id       = azurerm_key_vault.storage-keyvault.id
  storage_account_id = azurerm_storage_account.storage-account.id
  # storage_account_key          = azurerm_storage_account.storage-account.primary_access_key
  storage_account_key          = "key1" # or "key2"
  regenerate_key_automatically = false
  regeneration_period          = "P1D"
}

resource "azurerm_key_vault_managed_storage_account_sas_token_definition" "storage-keyvault-managed-storage-account-sas-token-definition" {
  name                       = "examplesasdefinition"
  validity_period            = "P1D"
  managed_storage_account_id = azurerm_key_vault_managed_storage_account.storage-keyvault-managed-storage-account.id
  sas_template_uri           = data.azurerm_storage_account_sas.storage-sas.sas
  sas_type                   = "account"
}

output "sas_url_query_string" {
  value     = data.azurerm_storage_account_sas.storage-sas.sas
  sensitive = true
}

output "key_vault_secret_permissions" {
  value = azurerm_key_vault.storage-keyvault.access_policy[0].secret_permissions
}

output "key_vault_storage_permissions" {
  value = azurerm_key_vault.storage-keyvault.access_policy[0].storage_permissions
}


output "key_vault_storage_getsas_permission" {
  value = contains(azurerm_key_vault.storage-keyvault.access_policy[0].storage_permissions, "GetSAS")
}
