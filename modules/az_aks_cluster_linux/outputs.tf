output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw

  sensitive = true
}

output "instructions" {
  value = <<EOH
  Run the following to add the new cluster information to your kube config:
  az aks get-credentials --resource-group ${var.rg_name} --name ${var.aks_cluster_name}
  EOH
}
