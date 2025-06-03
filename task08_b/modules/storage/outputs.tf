output "sas_token" {
  description = "The SAS token for the storage account."
  value       = data.azurerm_storage_account_sas.storage_sas.sas
}

output "blob_url" {
  description = "The URL of the storage blob."
  value       = azurerm_storage_blob.storage_blob.url
}