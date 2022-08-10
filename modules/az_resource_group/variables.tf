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
  description = "Location of the resource group."
}

variable "name" {
  description = "Name of the resource group."
}
