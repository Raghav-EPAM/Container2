variable "acr_name" {
  description = "The name of the Azure Container Registry."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the ACR will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the ACR will be created."
  type        = string
}

variable "sku" {
  description = "The SKU of the Azure Container Registry (e.g., 'Standard', 'Premium')."
  type        = string
}

variable "acr_task_name" {
  description = "The name of the ACR task that builds the Docker image."
  type        = string
}

variable "context_path" {
  description = "The path to the context for the Docker build, typically a ZIP archive in Azure Blob Storage."
  type        = string
}

variable "context_access_token" {
  description = "The access token for the context path, typically a Blob URL."
  type        = string
}

variable "context_sas_token" {
  description = "The SAS token for accessing the context path in Azure Blob Storage."
  type        = string
}

variable "tags" {
  description = "Optional tags for the Azure Container Registry."
  type        = map(string)
}

variable "docker_image_name" {
  description = "The name of the Docker image to be built and pushed to the ACR."
  type        = string
}

