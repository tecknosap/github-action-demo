terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.33.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {
    
  }
  subscription_id = var.subscription_id 
}


resource "azurerm_resource_group" "teckno" {
  name     = "teckno-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "teckno" {
  name                = "teckno-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.teckno.location
  resource_group_name = azurerm_resource_group.teckno.name
}

resource "azurerm_subnet" "teckno" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.teckno.name
  virtual_network_name = azurerm_virtual_network.teckno.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "teckno" {
  name                = "teckno-nic"
  location            = azurerm_resource_group.teckno.location
  resource_group_name = azurerm_resource_group.teckno.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.teckno.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "teckno" {
  name                = "teckno-machine"
  resource_group_name = azurerm_resource_group.teckno.name
  location            = azurerm_resource_group.teckno.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.teckno.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("${path.module}/keys/id_rsa.pub")

  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}