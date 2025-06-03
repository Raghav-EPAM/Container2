output "aci_ip_address" {
  value       = azurerm_container_group.redis.ip_address
  description = "IP address of the Redis container group"
}
output "redis_fqdn" {
  value       = azurerm_container_group.redis.fqdn
  description = "Fully qualified domain name of the Redis container group"
}
output "kv_secret_redis_hostname_id" {
  value       = azurerm_key_vault_secret.redis_url.id
  description = "ID of the Key Vault secret containing the Redis hostname"
}

output "kv_secret_redis_password_id" {
  value       = azurerm_key_vault_secret.redis_pwd.id
  description = "ID of the Key Vault secret containing the Redis password"
  sensitive   = true
}