output "kube_config" {
  description = "Kube config block"
  value       = azurerm_kubernetes_cluster.k8_cluster.kube_config_raw
  sensitive   = true
}

output "aks_kv_access_identity_id" {
  description = "value of the identity used for Key Vault access"
  value       = azurerm_kubernetes_cluster.k8_cluster.kubelet_identity[0].client_id
}