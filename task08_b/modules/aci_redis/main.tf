resource "random_password" "redis_pwd" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_container_group" "redis" {
  name                = var.aci_name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Public"
  os_type             = "Linux"
  restart_policy      = "Always"
  tags                = var.tags
  sku                 = var.redis_sku_name
  dns_name_label      = var.aci_name

  container {
    name   = var.container_name
    image  = var.container_image
    cpu    = "0.5"
    memory = "1.0"

    ports {
      port     = 6379
      protocol = "TCP"
    }

    commands = ["redis-server",
      "--protected-mode no",
      "--requirepass ${random_password.redis_pwd.result}"
    ]
  }
}

resource "azurerm_key_vault_secret" "redis_url" {
  name         = var.redis_hostname_secret_name
  value        = azurerm_container_group.redis.fqdn
  key_vault_id = var.keyvault_id
}

resource "azurerm_key_vault_secret" "redis_pwd" {
  name         = var.redis_primary_key_secret_name
  value        = random_password.redis_pwd.result
  key_vault_id = var.keyvault_id
}