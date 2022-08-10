variable "resource_prefix" {
  default     = "linux"
  description = "The prefix to be used with resource names so that they are unique"
}

variable "tags" {
  default     = []
  description = "value of tags to be applied to the resources created"
}

variable "rg_name" {
  description = "Name of the resource group."
}

variable "vnet_name" {
  description = "Name of the virtual network."
}

variable "subnet_name" {
  description = "Name of the subnet."
}

variable "nsg_name" {
  description = "Name of the network security group."
}

variable "ssh_pub_key" {
  description = "SSH public key to be used for the VM."
}

variable "ssh_key_file" {
  description = "SSH private key file to be used for the VM for provisioner activities."
}

variable "vm_size" {
  description = "Size of the VM."
  default     = "Standard_B2s"
}

variable "vm_userdata" {
  description = "User data to be passed to the VM."
  default     = []
}
