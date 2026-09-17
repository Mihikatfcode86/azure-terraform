terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "dev" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

resource "azurerm_virtual_network" "dev" {
  name                = var.vnet_name
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  address_space       = var.vnet_address_space

  tags = var.tags
}

resource "azurerm_subnet" "dev" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.dev.name
  virtual_network_name = azurerm_virtual_network.dev.name
  address_prefixes     = var.subnet_address_prefix
}

resource "azurerm_public_ip" "dev" {
  name                = "pip-${var.vm_name}"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name

  allocation_method = "Static"
  sku               = "Standard"

  tags = var.tags
}

resource "azurerm_network_security_group" "dev" {
  name                = "nsg-${var.vm_name}"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.allowed_ssh_source
    destination_address_prefix = "*"
  }

  tags = var.tags
}
resource "azurerm_network_interface" "dev" {
  name                = "nic-${var.vm_name}"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.dev.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.dev.id
  }

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "dev" {
  network_interface_id      = azurerm_network_interface.dev.id
  network_security_group_id = azurerm_network_security_group.dev.id
}

resource "azurerm_linux_virtual_machine" "dev" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.dev.name
  location            = azurerm_resource_group.dev.location
  size                = var.vm_size

  admin_username = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.dev.id
  ]

  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  os_disk {
    name                 = "osdisk-${var.vm_name}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "9-lvm-gen2"
    version   = "latest"
  }

  tags = var.tags
}
