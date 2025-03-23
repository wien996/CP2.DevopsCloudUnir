resource "azurerm_network_security_group" "nsg" {
  name                = "dpbCP2_nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                        = "dpbCP2_ssh_sr"
    priority                    = 1001
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                        = "HTTP"
    priority                    = 1011
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "80"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "nicnsga" {
 network_interface_id       = azurerm_network_interface.nic.id
 network_security_group_id  = azurerm_network_security_group.nsg.id
}