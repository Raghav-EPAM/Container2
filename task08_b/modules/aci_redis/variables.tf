variable "location" {
  description = "Location for the Redis instance"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name for the Redis instance"
  type        = string
}

variable "tags" {
  description = "Tags for the Redis instance"
  type        = map(string)
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "container_image" {
  description = "Container image for the Redis instance"
  type        = string
}

variable "keyvault_id" {
  description = "ID of the Key Vault to store secrets"
  type        = string
}

variable "aci_name" {
  description = "Name of the Redis instance"
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "Name of the Key Vault secret for Redis hostname"
  type        = string
}

variable "redis_primary_key_secret_name" {
  description = "Name of the Key Vault secret for Redis primary key"
  type        = string
}

variable "redis_sku_name" {
  description = "The SKU name for the Azure Container Instance"
  type        = string
}