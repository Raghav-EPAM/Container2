variable "aca_name" {
  description = "Name of the Azure Container App"
  type        = string
}

variable "location" {
  description = "Azure region where the Container App will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group where the Container App will be deployed"
  type        = string
}

variable "container_name" {
  description = "Name of the container within the Azure Container App"
  type        = string
}

variable "container_image" {
  description = "Docker image for the container"
  type        = string
}

variable "revision_mode" {
  description = "Revision mode for the Azure Container App"
  type        = string
}

variable "acr_server" {
  description = "Container registry server URL"
  type        = string
}

variable "keyvault_id" {
  description = "ID of the Azure Key Vault for secrets management"
  type        = string
}

variable "env_name" {
  description = "Name of the Azure Container App Environment"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Azure Container App"
  type        = map(string)
}

variable "acr_id" {
  description = "ID of the Azure Container Registry for image pulling"
  type        = string
}

variable "kv_secret_redis_hostname_id" {
  description = "Key Vault secret ID for Redis hostname"
  type        = string
}

variable "kv_secret_redis_password_id" {
  description = "Key Vault secret ID for Redis password"
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID for Azure authentication"
  type        = string
}