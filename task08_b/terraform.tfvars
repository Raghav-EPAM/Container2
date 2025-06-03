#common values
location    = "westus"
name_prefix = "cmtr-wp09pu9z-mod8b"

#storage
container_access_type = "private"
archive_type          = "tar.gz"
archive_source_dir    = "application"
archive_output_path   = "new.tar.gz"
storage_blob_name     = "raghav-blob1"
content_type          = "application/gzip"


#acr
acr_sku       = "Basic"
acr_task_name = "build-app-image"
context_path  = "application"


#keyvault
kv_sku_name = "standard"

#aci-redis
redis_sku_name = "Standard"

#aca
revision_mode = "Single"

#aks
aks_node_pool_name          = "system"
system_node_pool_node_count = 1