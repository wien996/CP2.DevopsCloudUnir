
resource "random_string" "acr_suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "azurerm_container_registry" "acr" {
  name                = "dpbCP2acr${random_string.acr_suffix.result}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true

  tags = var.tags
}