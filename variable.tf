# Resource Group
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "combined_resource_group"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "canadacentral"
}

# Virtual Network and Subnet
variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "combined-vnet"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "combined-subnet"
}

# Linux VM
variable "linux_vm_name" {
  description = "Name of the Linux virtual machine"
  type        = string
  default     = "linux-vm"
}

variable "linux_vm_size" {
  description = "Size of the Linux virtual machine"
  type        = string
  default     = "Standard_F2"
}

variable "linux_nic_name" {
  description = "Name of the Linux network interface"
  type        = string
  default     = "linux-nic"
}

variable "linux_admin_username" {
  description = "Admin username for the Linux VM"
  type        = string
  default     = "linuxadmin"
}

variable "linux_admin_password" {
  description = "Admin password for the Linux VM"
  type        = string
  sensitive   = true
}

# Windows VM
variable "windows_vm_name" {
  description = "Name of the Windows virtual machine"
  type        = string
  default     = "windows-vm"
}

variable "windows_vm_size" {
  description = "Size of the Windows virtual machine"
  type        = string
  default     = "Standard_F2"
}

variable "windows_nic_name" {
  description = "Name of the Windows network interface"
  type        = string
  default     = "windows-nic"
}

variable "windows_admin_username" {
  description = "Admin username for the Windows VM"
  type        = string
  default     = "windowsadmin"
}

variable "windows_admin_password" {
  description = "Admin password for the Windows VM"
  type        = string
  sensitive   = true
}

# Tags
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    environment = "development"
    owner       = "joseph"
  }
}
