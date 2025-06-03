provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "resource_group" {
  name     = local.rg_name
  location = var.location
  tags     = local.common_tags
}

module "storage" {
  source = "./modules/storage"

  storage_account_name = local.sa_name
  location             = azurerm_resource_group.resource_group.location
  resource_group_name  = azurerm_resource_group.resource_group.name
  tags                 = local.common_tags

  storage_container_name = local.container_name
  container_access_type  = var.container_access_type

  archive_type        = var.archive_type
  archive_source_dir  = var.archive_source_dir
  archive_output_path = var.archive_output_path

  storage_blob_name = var.storage_blob_name
  content_type      = var.content_type
}

module "acr" {
  source = "./modules/acr"

  acr_name            = local.acr_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  tags                = local.common_tags

  sku                  = var.acr_sku
  acr_task_name        = var.acr_task_name
  context_path         = module.storage.blob_url
  context_access_token = module.storage.sas_token
  docker_image_name    = local.app_image_name
  context_sas_token    = module.storage.sas_token

  depends_on = [module.storage]
}

module "keyvault" {
  source = "./modules/keyvault"

  keyvault_name = local.keyvault_name
  location      = azurerm_resource_group.resource_group.location
  tags          = local.common_tags
  rg_name       = azurerm_resource_group.resource_group.name


  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id
  sku_name  = var.kv_sku_name

  depends_on = [module.storage, module.acr]
}

module "aci_redis" {
  source = "./modules/aci_redis"

  aci_name            = local.redis_aci_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  tags                = local.common_tags
  redis_sku_name      = var.redis_sku_name

  redis_hostname_secret_name    = local.redis_hostname_secret_name
  redis_primary_key_secret_name = local.redis_primary_key_secret_name

  container_name  = local.container_name
  container_image = "mcr.microsoft.com/cbl-mariner/base/redis:6"

  keyvault_id = module.keyvault.keyvault_id

  depends_on = [module.acr, module.keyvault]

}

module "aca" {
  source = "./modules/aca"

  aca_name            = local.aca_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  tags                = local.common_tags

  acr_id      = module.acr.acr_id
  keyvault_id = module.keyvault.keyvault_id
  tenant_id   = data.azurerm_client_config.current.tenant_id

  kv_secret_redis_hostname_id = module.aci_redis.kv_secret_redis_hostname_id
  kv_secret_redis_password_id = module.aci_redis.kv_secret_redis_password_id
  container_name              = local.container_name
  container_image             = "${module.acr.login_server}/${local.app_image_name}:latest"

  revision_mode = var.revision_mode
  env_name      = local.aca_env_name
  acr_server    = module.acr.login_server

  depends_on = [module.aci_redis]
}

module "aks" {
  source = "./modules/aks"

  aks_name            = local.aks_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  tags                = local.common_tags

  dns_prefix                  = local.dns_prefix
  system_node_pool_name       = var.aks_node_pool_name
  system_node_pool_node_count = var.system_node_pool_node_count
  acr_id                      = module.acr.acr_id
  key_vault_id                = module.keyvault.keyvault_id
  tenant_id                   = data.azurerm_client_config.current.tenant_id

  depends_on = [module.acr, module.keyvault, module.aca]
}

provider "kubectl" {
  host                   = yamldecode(module.aks.kube_config).clusters[0].cluster.server
  client_certificate     = base64decode(yamldecode(module.aks.kube_config).users[0].user.client-certificate-data)
  client_key             = base64decode(yamldecode(module.aks.kube_config).users[0].user.client-key-data)
  cluster_ca_certificate = base64decode(yamldecode(module.aks.kube_config).clusters[0].cluster.certificate-authority-data)
  load_config_file       = false
}

provider "kubernetes" {
  host                   = yamldecode(module.aks.kube_config).clusters[0].cluster.server
  client_certificate     = base64decode(yamldecode(module.aks.kube_config).users[0].user.client-certificate-data)
  client_key             = base64decode(yamldecode(module.aks.kube_config).users[0].user.client-key-data)
  cluster_ca_certificate = base64decode(yamldecode(module.aks.kube_config).clusters[0].cluster.certificate-authority-data)
}

module "k8s" {
  source = "./modules/k8s"

  aks_kv_access_identity_id     = module.aks.aks_kv_access_identity_id
  keyvault_name                 = local.keyvault_name
  redis_hostname_secret_name    = local.redis_hostname_secret_name
  redis_primary_key_secret_name = local.redis_primary_key_secret_name

  acr_login_server = module.acr.login_server
  app_image_name   = local.app_image_name

  depends_on = [module.aks]

}