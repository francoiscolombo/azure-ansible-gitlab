#========================================================================================
#--- Parameters -------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
variable "admin_username" {
  description = "Give administrator user name: "
}

variable "ssh_public_key" {
  description = "Content of public key for ssh access: "
}

variable "ssh_key_private" {
  description = "Path to private ssh key used for access: "
}

variable "ansible_playbook" {
  description = "Path to ansible playbook to execute for provisioning: "
}

variable "ansible_platform" {
  description = "Path to ansible platform description file: "
}

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

variable "subnet_address_space" {
  description = "the subset of the virtual network for this subnet"
}

variable "storage_account_type" {
  description = "type of storage account"
}

variable "storage_account_tier" {
  description = "tier of storage account"
}

variable "storage_account_name" {
  description = "name of your storage account"
}

variable "name_prefix" {
  description = "Set unique part of the name to give to resources: "
}

variable "image_publisher" {
  description = "name of the publisher of the image (az vm image list)"
}

variable "image_offer" {
  description = "the name of the offer (az vm image list)"
}

variable "image_sku" {
  description = "image sku to apply (az vm image list)"
}

variable "image_version" {
  description = "version of the image to apply (az vm image list)"
}

variable "servers" {
  description = "list of public servers to create in the infrastructure"
  type = "list"
  default = [
    {
      name = "0"
      private_ip = "10.10.10.10"

      ipconfig = "0"

      name_ssh_rule = "ssh-0"
      name_https_rule = "https-0"
      name_http_rule = "http-0"
      name_http2_rule = "http-1"
      name_rsync_rule = "rsync-0"

      pip_name = "keyteo-azure-gitlab-pip"
      
      cname = "keyteo-gitlab"
      vmsize = "Standard_D2_v2"
      disksize = "120"
    }
  ]
}
