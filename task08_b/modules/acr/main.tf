resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = true

  tags = var.tags
}

resource "azurerm_container_registry_task" "acr_task" {
  name                  = var.acr_task_name
  container_registry_id = azurerm_container_registry.acr.id


  platform {
    os = "Linux"
  }

  docker_step {
    dockerfile_path      = "Dockerfile"
    context_path         = var.context_path
    context_access_token = var.context_access_token
    image_names          = [var.docker_image_name]
  }
}

resource "azurerm_container_registry_task_schedule_run_now" "acr_task_now" {
  container_registry_task_id = azurerm_container_registry_task.acr_task.id
}