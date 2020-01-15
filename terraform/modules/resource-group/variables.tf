variable "resource_group" {
  description = "Resource group name"
}

variable "environment" {
  description = "Environment to create (will be present as a tag)"
}

variable "location" {
  description = "region where the resources should exist"
}
