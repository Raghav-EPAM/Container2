output "aca_dns" {
  description = "DNS name of the Azure Container App"
  value       = azurerm_container_app.aca.latest_revision_fqdn
}