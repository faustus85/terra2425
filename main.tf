# Resource Group
resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "virtual_network" {
  name                = var.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Network Interface for Linux VM
resource "azurerm_network_interface" "linux_nic" {
  name                = var.linux_nic_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "linux-ip-config"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Network Interface for Windows VM
resource "azurerm_network_interface" "windows_nic" {
  name                = var.windows_nic_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "windows-ip-config"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                = var.linux_vm_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  size                = var.linux_vm_size
  admin_username      = var.linux_admin_username
  admin_password      = var.linux_admin_password

  network_interface_ids = [
    azurerm_network_interface.linux_nic.id,
  ]

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

  tags = var.tags
}

# Windows Virtual Machine
resource "azurerm_windows_virtual_machine" "windows_vm" {
  name                = var.windows_vm_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  size                = var.windows_vm_size
  admin_username      = var.windows_admin_username
  admin_password      = var.windows_admin_password

  network_interface_ids = [
    azurerm_network_interface.windows_nic.id,
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

  tags = var.tags
}

# Outputs
output "linux_vm_private_ip" {
  description = "Private IP of the Linux VM"
  value       = azurerm_network_interface.linux_nic.private_ip_address
}

output "windows_vm_private_ip" {
  description = "Private IP of the Windows VM"
  value       = azurerm_network_interface.windows_nic.private_ip_address
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.resource_group.name
}
