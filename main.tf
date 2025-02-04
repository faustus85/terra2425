resource "azurerm_resource_group" "mcitjoseph24" {
  name     = "joe_resource_group_w24"
  location = "canadacentral"
}

resource "azurerm_virtual_network" "joseph" {
  name                = "joseph-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.mcitjoseph24.location
  resource_group_name = azurerm_resource_group.mcitjoseph24.name
}

resource "azurerm_subnet" "josephsubnet" {
  name                 = "joseph"
  resource_group_name  = azurerm_resource_group.mcitjoseph24.name
  virtual_network_name = azurerm_virtual_network.joseph.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "josephtest" {
  name                = "w1"
  location            = azurerm_resource_group.mcitjoseph24.location
  resource_group_name = azurerm_resource_group.mcitjoseph24.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.josephsubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = "faustus-machine"
  resource_group_name = azurerm_resource_group.mcitjoseph24.name
  location            = azurerm_resource_group.mcitjoseph24.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
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
