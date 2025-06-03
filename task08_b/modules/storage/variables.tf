variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the storage account will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the storage account will be created."
  type        = string
}

variable "tags" {
  description = "Common tags to be applied to the storage account."
  type        = map(string)
}

variable "archive_type" {
  description = "The type of archive to create (e.g., 'zip', 'tar')."
  type        = string
}

variable "archive_source_dir" {
  description = "The source directory to archive."
  type        = string
}

variable "archive_output_path" {
  description = "The output path for the archive file."
  type        = string
}

variable "storage_container_name" {
  description = "The name of the storage container."
  type        = string
}

variable "container_access_type" {
  description = "The access type for the storage container (e.g., 'private', 'blob', 'container')."
  type        = string
}

variable "storage_blob_name" {
  description = "The name of the storage blob."
  type        = string
}

variable "content_type" {
  description = "The content type of the blob."
  type        = string
}