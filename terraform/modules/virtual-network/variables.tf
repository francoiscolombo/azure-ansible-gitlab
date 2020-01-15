variable "resource_group" {
  description = "Resource group name"
}

variable "environment" {
  description = "Environment to create (will be present as a tag)"
}

variable "location" {
  description = "region where the resources should exist"
}

variable "vnet_address_space" {
  description = "full address space allowed to the virtual network"
}

variable "virtual_network_name" {
  description = "name of the resource"
}