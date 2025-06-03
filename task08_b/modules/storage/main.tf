# Archive the application directory and upload it to Azure Storage
data "archive_file" "archive_file" {
  type        = var.archive_type
  source_dir  = var.archive_source_dir
  output_path = var.archive_output_path
}

# Create a storage account in Azure
resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

# Create a storage container in the storage account
resource "azurerm_storage_container" "storage_container" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = var.container_access_type
}

# Upload the archive file to the storage container
resource "azurerm_storage_blob" "storage_blob" {
  name                   = var.storage_blob_name
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.storage_container.name
  type                   = "Block"
  content_type           = var.content_type
  source                 = data.archive_file.archive_file.output_path
}

resource "time_static" "start_time" {}

resource "time_offset" "expiry_time" {
  offset_hours = 1
  base_rfc3339 = time_static.start_time.rfc3339
}

# SAS Token for the Container
data "azurerm_storage_account_sas" "storage_sas" {
  connection_string = azurerm_storage_account.storage_account.primary_connection_string
  https_only        = true
  start             = time_static.start_time.rfc3339
  expiry            = time_offset.expiry_time.rfc3339

  resource_types {
    service   = false
    container = false
    object    = true
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  permissions {
    read    = true
    write   = false
    delete  = false
    add     = false
    tag     = false
    process = false
    filter  = false
    update  = false
    list    = false
    create  = false
  }

}