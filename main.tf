provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "azjoerg" {
  name     = "azjoe-resources"
  location = "central canada"
}

resource "azurerm_virtual_network" "azjoevn" {
  name                = "azjoe-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.azjoerg.location
  resource_group_name = azurerm_resource_group.azjoerg.name
}

resource "azurerm_subnet" "azjoesubnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.azjoerg.name
  virtual_network_name = azurerm_virtual_network.azjoevn.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "azjoeni" {
  name                = "joe-nic"
  location            = azurerm_resource_group.azjoerg.location
  resource_group_name = azurerm_resource_group.azjoerg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.azjoesubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "azjoevm" {
  name                = "azjoevm"
  resource_group_name = azurerm_resource_group.azjoerg.name
  location            = azurerm_resource_group.azjoerg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "zozo1985"
  network_interface_ids = [
    azurerm_network_interface.azjoeni.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
