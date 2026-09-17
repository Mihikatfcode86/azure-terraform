variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "vnet_name" {
  description = "Virtual Network name"
  type        = string
}

variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "subnet_address_prefix" {
  description = "Subnet address prefix"
  type        = list(string)
}

variable "vm_name" {
  description = "RHEL VM name"
  type        = string
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
}

variable "admin_username" {
  description = "Administrator username"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
  sensitive   = true
}

variable "allowed_ssh_source" {
  description = "Source CIDR permitted to SSH to the VM"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
