variable "resource_prefix" {
  description = "The prefix to be used with resource names so that they are unique"
}

variable "source_address_prefix" {
  default     = "*"
  description = "The source CIDR range allowed to connect to resources in the VNET."
}

variable "tags" {
  default     = []
  description = "value of tags to be applied to the resources created"
}

variable "location" {
  default     = "eastus"
  description = "Location of the virtual network"
}

variable "rg_name" {
  description = "Name of the resource group"
}

variable "vnet_address_space" {
  default     = ["172.30.0.0/16"]
  description = "The address space of the virtual network"
}

variable "vnet_subnet_address_prefix" {
  default     = "172.30.0.0/24"
  description = "The address prefix of the virtual network subnet"
}
