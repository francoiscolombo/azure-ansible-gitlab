variable "resource_group" {
  description = "Resource group name"
}

variable "environment" {
  description = "Environment to create (will be present as a tag)"
}

variable "location" {
  description = "region where the resources should exist"
}

variable "storage_account_name" {
  description = "name of your storage account"
}

variable "storage_account_type" {
  description = "type of storage account"
}

variable "storage_account_tier" {
  description = "tier of storage account"
}

variable "storage_container_name" {
  description = "name of your storage container"
}
