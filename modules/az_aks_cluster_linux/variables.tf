variable "rg_name" {
  description = "Name of the resource group."
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

variable "source_address_prefix" {
  default     = ["*"]
  description = "The source CIDR range allowed to connect to resources in the VNET."
}

variable "tags" {
  default     = []
  description = "value of tags to be applied to the resources created"
}

variable "aks_cluster_name" {
  description = "Name of the AKS cluster."
}

variable "aks_cluster_location" {
  description = "Location of the AKS cluster."
}

variable "aks_cluster_dns_prefix" {
  description = "DNS prefix to use with the created AKS cluster."
}

variable "aks_cluster_http_application_routing_enabled" {
  description = "Whether to enable HTTP Application Routing on the AKS cluster."
  default     = false
}
