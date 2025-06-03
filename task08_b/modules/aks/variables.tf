variable "aks_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group for the AKS cluster"
  type        = string
}

variable "location" {
  description = "Location for the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "system_node_pool_name" {
  description = "Name of the system node pool"
  type        = string
}

variable "system_node_pool_node_count" {
  description = "Number of nodes in the system node pool"
  type        = number
}

variable "acr_id" {
  description = "ID of the Azure Container Registry"
  type        = string
}

variable "key_vault_id" {
  description = "ID of the Azure Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID for the Azure subscription"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the AKS cluster"
  type        = map(string)
}