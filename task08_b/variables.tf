variable "name_prefix" {
  description = "A prefix for naming resources"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "container_access_type" {
  description = "The access type for the storage container (e.g., 'private', 'blob', 'container')"
  type        = string
}

variable "archive_type" {
  description = "The type of archive to create (e.g., 'zip', 'tar')"
  type        = string
}

variable "archive_source_dir" {
  description = "The source directory to archive"
  type        = string
}

variable "archive_output_path" {
  description = "The output path for the archived file"
  type        = string
}

variable "storage_blob_name" {
  description = "The name of the storage blob to create"
  type        = string
}

variable "acr_sku" {
  description = "The SKU for the Azure Container Registry (e.g., 'Basic', 'Standard', 'Premium')"
  type        = string
}

variable "context_path" {
  description = "The context path for the Docker build"
  type        = string
}

variable "revision_mode" {
  description = "The revision mode for the Azure Container App (e.g., 'Single', 'Multiple')"
  type        = string
}

variable "aks_node_pool_name" {
  description = "The name of the system node pool for the AKS cluster"
  type        = string
}

variable "system_node_pool_node_count" {
  description = "The number of nodes in the system node pool for the AKS cluster"
  type        = number
}
variable "content_type" {
  description = "The content type of the blob"
  type        = string
}

variable "acr_task_name" {
  description = "The name of the Azure Container Registry task"
  type        = string
}

variable "redis_sku_name" {
  description = "The SKU name for the Key Vault"
  type        = string
}

variable "kv_sku_name" {
  description = "The SKU name for the Key Vault"
  type        = string
}