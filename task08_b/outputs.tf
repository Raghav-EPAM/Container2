output "aca_fqdn" {
  value       = module.aca.aca_dns
  description = "value"
}
output "redis_fqdn" {
  value       = module.aci_redis.redis_fqdn
  description = "value"
}
output "aks_lb_ip" {
  value       = module.k8s.aks_lb_ip
  description = "value"
}