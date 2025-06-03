variable "aks_kv_access_identity_id" {
  description = "The identity ID used to access the Key Vault from AKS"
  type        = string
}

variable "keyvault_name" {
  description = "The name of the Azure Key Vault"
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "The name of the secret for the Redis hostname"
  type        = string
}

variable "redis_primary_key_secret_name" {
  description = "The name of the secret for the Redis primary key"
  type        = string
}

variable "acr_login_server" {
  description = "The name of the Azure Container Registry"
  type        = string
}

variable "app_image_name" {
  description = "The name of the application image to be deployed"
  type        = string
}