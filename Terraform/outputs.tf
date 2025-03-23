output "ip_address" {
  value         = azurerm_public_ip.pip.ip_address
  description   = "Dirección ip pública de linux en azure"
}

output "acr_admin_username" {
  value         = azurerm_container_registry.acr.admin_username
  description   = "Dirección ip pública de linux en azure"
  sensitive     = true
}

output "acr_admin_password" {
  value         = azurerm_container_registry.acr.admin_password
  description   = "Dirección ip pública de linux en azure"
  sensitive     = true
}