data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                             = "${var.aks_cluster_dns_prefix}-cluster"
  location                         = var.aks_cluster_location
  resource_group_name              = data.azurerm_resource_group.rg.name
  dns_prefix                       = var.aks_cluster_dns_prefix
  api_server_authorized_ip_ranges  = var.source_address_prefix
  http_application_routing_enabled = var.aks_cluster_http_application_routing_enabled

  default_node_pool {
    name                = "nodepool01"
    max_count           = 5
    min_count           = 2
    vm_size             = var.vm_size
    enable_auto_scaling = true
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
