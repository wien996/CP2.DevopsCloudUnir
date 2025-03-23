resource "azurerm_kubernetes_cluster" "aks" {
  name                = "dpbCP2_aks"
  resource_group_name = var.resource_group_name
  location            = var.location
  dns_prefix          = "dpbCP2aks"
  kubernetes_version  = "1.32.0"
   
  default_node_pool {
    name        = "default"
    node_count  = 1
    vm_size    = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

  identity {
    type    = "SystemAssigned"
  }

  tags = var.tags

  depends_on = [azurerm_virtual_network.vn]
}