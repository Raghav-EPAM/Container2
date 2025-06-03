locals {

  rg_name = format("%s-rg", var.name_prefix)

  # ACR (lowercase, no dashes per naming rules)
  acr_name = lower(replace(format("%scr", var.name_prefix), "-", ""))

  # Storage Account Name (lowercase, no dashes per naming rules)
  sa_name = lower(replace(format("%ssa", var.name_prefix), "-", ""))

  # App Image Name
  app_image_name = format("%s-app", var.name_prefix)

  # ACI
  aci_name = format("%s-ci", var.name_prefix)

  # ACA
  aca_name     = format("%s-ca", var.name_prefix)
  aca_env_name = format("%s-cae", var.name_prefix)

  # AKS
  aks_name = format("%s-aks", var.name_prefix)

  # Redis
  redis_aci_name = format("%s-redis-ci", var.name_prefix)

  # Key Vault
  keyvault_name = format("%s-kv", var.name_prefix)

  # KV Secret Names
  redis_hostname_secret_name    = "redis-hostname"
  redis_primary_key_secret_name = "redis-password"

  # Common tags
  common_tags = {
    Creator = "raghav_jaiswal@epam.com"
  }
  container_name     = "app-content"
  dns_prefix         = "${var.name_prefix}-k8s"
  aks_node_pool_name = "system"
}