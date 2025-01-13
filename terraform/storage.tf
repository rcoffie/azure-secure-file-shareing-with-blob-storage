# Generate a unique name for the storage container
resource "random_string" "unique_id" {
  length  = 6
  special = false
  upper   = false
}


# Create a Storage Account
resource "azurerm_storage_account" "storage-account" {
  name                     = "stgacct${random_string.unique_id.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create a Storage Container
resource "azurerm_storage_container" "storage-container" {
  name                  = "storagecontainer${random_string.unique_id.result}"
  storage_account_name  = azurerm_storage_account.storage-account.name
  container_access_type = "private"
}

# Retrieve the Azure AD user
data "azuread_user" "storage-users" {
  user_principal_name = "cadmin@lawcof.com"
}

# Create an Azure AD group
resource "azuread_group" "storage-group" {
  display_name     = "storage-group"
  security_enabled = true
  owners           = [data.azuread_user.storage-users.object_id]
}

# Add the user to an Azure AD group
resource "azuread_group_member" "storage-group-members" {
  group_object_id  = azuread_group.storage-group.object_id
  member_object_id = data.azuread_user.storage-users.object_id
}

# Assign the role to the Azure AD group created
resource "azurerm_role_assignment" "storage-role-assignment" {
  scope                = azurerm_storage_account.storage-account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_group.storage-group.object_id
}

# Create SAS token for the storage account
data "azurerm_storage_account_sas" "storage-account-sas" {
  connection_string = azurerm_storage_account.storage-account.primary_connection_string
  https_only        = true

  resource_types {
    service   = true
    container = true
    object    = true
  }

  services {
    blob  = true
    queue = true
    table = true
    file  = true
  }

  start  = "2025-01-01T00:00:00Z"
  expiry = "2026-01-01T00:00:00Z"

  permissions {
    read    = true
    add     = true
    create  = true
    write   = true
    delete  = true
    list    = true
    update  = true
    process = true
    tag     = true
    filter  = true
  }
}


# Create sas token
data "azurerm_storage_account_sas" "storage-sas" {
  connection_string = azurerm_storage_account.storage-account.primary_connection_string
  https_only        = true
  signed_version    = "2017-07-29"

  resource_types {
    service   = false
    container = true
    object    = false
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = "2024-01-01T00:00:00Z"
  expiry = "2025-01-01T00:00:00Z"


  permissions {
    read    = true
    write   = true
    delete  = false
    list    = true
    add     = true
    create  = true
    update  = true
    process = false
    tag     = false
    filter  = false
  }
}
