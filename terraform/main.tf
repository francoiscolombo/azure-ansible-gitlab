module "resource-group" {

  source = "modules/resource-group"

  environment = "${var.environment}"

  location = "${var.location}"

  resource_group = "${var.resource_group}"

}

module "vnet" {
  source = "modules/virtual-network"

  environment    = "${module.resource-group.resource_group_environment}"
  location       = "${module.resource-group.resource_group_location}"
  resource_group = "${module.resource-group.resource_group_name}"

  virtual_network_name = "${var.name_prefix}-vnet"
  vnet_address_space   = "${var.vnet_address_space}"

}

module "subnet" {

  source = "modules/subnet"

  resource_group = "${module.resource-group.resource_group_name}"

  vnet_name = "${module.vnet.vnet_name}"

  subnet_name          = "${var.name_prefix}-subnet"
  subnet_address_space = "${var.subnet_address_space}"

}

module "storage" {

  source = "modules/storage-account"

  environment    = "${module.resource-group.resource_group_environment}"
  location       = "${module.resource-group.resource_group_location}"
  resource_group = "${module.resource-group.resource_group_name}"

  storage_account_type   = "${var.storage_account_type}"
  storage_account_tier   = "${var.storage_account_tier}"
  storage_account_name   = "${var.storage_account_name}"
  storage_container_name = "${var.name_prefix}-vhds"

}

module "virtual-machines" {

  source = "modules/virtual-machines"

  environment    = "${module.resource-group.resource_group_environment}"
  location       = "${module.resource-group.resource_group_location}"
  resource_group = "${module.resource-group.resource_group_name}"

  name_prefix = "${var.name_prefix}"

  admin_username  = "${var.admin_username}"
  ssh_key_private = "${var.ssh_key_private}"
  ssh_public_key  = "${var.ssh_public_key}"

  subnet_id = "${module.subnet.subnet_id}"

  blob_connection_string = "${module.storage.blob_connection_string}"

  image_publisher = "${var.image_publisher}"
  image_offer     = "${var.image_offer}"
  image_sku       = "${var.image_sku}"
  image_version   = "${var.image_version}"

  servers = "${var.servers}"

  ansible_playbook = "${var.ansible_playbook}"
  ansible_platform = "${var.ansible_platform}"

}
