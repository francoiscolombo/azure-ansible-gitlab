variable "resource_group" {
  description = "Resource group name"
}

variable "subnet_name" {
  description = "subnet name"
}

variable "vnet_name" {
  description = "name of the vnet resource to be attached to"
}

variable "subnet_address_space" {
  description = "the subset of the virtual network for this subnet"
}
