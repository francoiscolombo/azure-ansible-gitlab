output "resource_group_environment" {
  value = "${module.resource-group.resource_group_environment}"
}

output "resource_group_location" {
  value = "${module.resource-group.resource_group_location}"
}

output "resource_group_name" {
  value = "${module.resource-group.resource_group_name}"
}

output "subnet_id" {
  value = "${module.subnet.subnet_id}"
}

output "public_fqdn" {
  value = "${module.virtual-machines.public_fqdn}"
}

output "public_ip_id" {
  value = "${module.virtual-machines.public_ip_id}"
}

output "blob_connection_string" {
  value = "${module.storage.blob_connection_string}"
}

output "storage_account_name" {
  value = "${module.storage.storage_name}"
}

output "storage_account_key" {
  value = "${module.storage.storage_account_key}"
}