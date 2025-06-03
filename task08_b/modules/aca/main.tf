// 1. User Assigned Managed Identity
resource "azurerm_user_assigned_identity" "aca_identity" {
  name                = "aca_identity"
  location            = var.location
  resource_group_name = var.resource_group_name
}

// 2. Key Vault Access Policy
resource "azurerm_key_vault_access_policy" "aca_kv_policy" {
  key_vault_id = var.keyvault_id
  tenant_id    = var.tenant_id
  object_id    = azurerm_user_assigned_identity.aca_identity.principal_id

  secret_permissions = ["Get", "List", "Set", "Delete", "Recover", "Purge", "Backup", "Restore"]

  depends_on = [azurerm_role_assignment.acr_pull]
}

// 3. Role Assignment to allow ACA to pull images from ACR
resource "azurerm_role_assignment" "acr_pull" {
  principal_id         = azurerm_user_assigned_identity.aca_identity.principal_id
  role_definition_name = "AcrPull"
  scope                = var.acr_id #Pass value in root main.tf file
}

// 4. Container App Environment
resource "azurerm_container_app_environment" "env" {
  name                = var.env_name
  location            = var.location
  resource_group_name = var.resource_group_name

  workload_profile {
    name                  = "Consumption"
    workload_profile_type = "Consumption"
  }

  depends_on = [azurerm_key_vault_access_policy.aca_kv_policy]
}

// 5. Azure Container App
resource "azurerm_container_app" "aca" {
  name                         = var.aca_name
  resource_group_name          = var.resource_group_name
  container_app_environment_id = azurerm_container_app_environment.env.id
  revision_mode                = var.revision_mode
  workload_profile_name        = "Consumption"
  tags                         = var.tags

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aca_identity.id]
  }

  registry {
    server   = var.acr_server
    identity = azurerm_user_assigned_identity.aca_identity.id
  }

  secret {
    name                = "redis-url"
    identity            = azurerm_user_assigned_identity.aca_identity.id
    key_vault_secret_id = var.kv_secret_redis_hostname_id
  }

  secret {
    name                = "redis-key"
    identity            = azurerm_user_assigned_identity.aca_identity.id
    key_vault_secret_id = var.kv_secret_redis_password_id
  }

  template {
    container {
      name   = var.container_name
      image  = var.container_image
      cpu    = "0.5"
      memory = "1.0Gi"

      env {
        name  = "CREATOR"
        value = "ACA"
      }
      env {
        name  = "REDIS_PORT"
        value = "6379"
      }
      env {
        name        = "REDIS_URL"
        secret_name = "redis-url"
      }
      env {
        name        = "REDIS_PWD"
        secret_name = "redis-key"
      }
    }
  }
  ingress {
    allow_insecure_connections = false
    external_enabled           = true
    transport                  = "auto"
    target_port                = 8080

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}

