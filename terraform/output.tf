# Output SAS token to file
resource "local_file" "sas_token_file" {
  content         = data.azurerm_storage_account_sas.storage-account-sas.sas
  filename        = "${path.module}/sas_token.txt"
  file_permission = "0600"
}

# Output Blob Service URL to file
resource "local_file" "blob_url_file" {
  content         = "https://${azurerm_storage_account.storage-account.name}.blob.core.windows.net"
  filename        = "${path.module}/blob_url.txt"
  file_permission = "0600"
}

#  Output Container URL to file
resource "local_file" "container_url_file" {
  content         = "https://${azurerm_storage_account.storage-account.name}.blob.core.windows.net/${azurerm_storage_container.storage-container.name}"
  filename        = "${path.module}/container_url.txt"
  file_permission = "0600"
}

# Output full SAS token URL to file
resource "local_file" "sas_url_file" {
  content         = "https://${azurerm_storage_account.storage-account.name}.blob.core.windows.net/${azurerm_storage_container.storage-container.name}${data.azurerm_storage_account_sas.storage-account-sas.sas}"
  filename        = "${path.module}/sas_url.txt"
  file_permission = "0600"
}

# # Output values (for reference)
output "storage_account_name" {
  value = azurerm_storage_account.storage-account.name
}

output "container_name" {
  value = azurerm_storage_container.storage-container.name
}

provider "local" {}

resource "local_file" "output_file" {
  filename = "sas_and_keys.txt"
  content  = <<EOF
SAS Token:
${azurerm_key_vault_managed_storage_account_sas_token_definition.storage-keyvault-managed-storage-account-sas-token-definition.sas_template_uri}

Storage Account Key:
${azurerm_key_vault_managed_storage_account.storage-keyvault-managed-storage-account.storage_account_key}
EOF
}
