resource "azurerm_virtual_network" "vn" {
  name                = "dpbCP2_vn"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["XX.X.X.X/XX"]
  tags = var.tags
}

resource "azurerm_subnet" "sn" {
  name                 = "dpbCP2_sn"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = ["XX.X.X.X/XX"]
}

resource "azurerm_network_interface" "nic" {
  name                      = "dpbCP2_nic"
  location                  = var.location
  resource_group_name       = var.resource_group_name

  ip_configuration {
    name                          = "dpbCP2_ipc"
    subnet_id                     = azurerm_subnet.sn.id
    private_ip_address_allocation = "Dynamic"
    private_ip_address            = "XX.X.X.X"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
  tags = var.tags
}

resource "azurerm_public_ip" "pip" {
  name                = "dpbCP2_pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  tags = var.tags
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_linux_virtual_machine" "lvm" {
  name                = "dpbCP2_ubuntuserver_lvm"
  computer_name       = "dpbCP2-ubuntuserver"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_size
  admin_username      = "adminuser"
  network_interface_ids = [azurerm_network_interface.nic.id]

  admin_ssh_key {
    username   = "adminuser" 
    public_key = tls_private_key.ssh_key.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  tags = var.tags

  depends_on = [azurerm_virtual_network.vn]
}
