resource "azurerm_key_vault" "keyvault" {
  name                = var.keyvault_name
  location            = var.location
  resource_group_name = var.rg_name
  tenant_id           = var.tenant_id
  sku_name            = var.sku_name

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "keyvault_policy" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.tenant_id
  object_id    = var.object_id

  secret_permissions = ["Get", "List", "Set", "Purge", "Delete", "Recover", "Backup", "Restore"]
}
