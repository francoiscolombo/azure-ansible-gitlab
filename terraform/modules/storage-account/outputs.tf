output "blob_connection_string" {
  value = "${azurerm_storage_account.stor-dev.primary_blob_endpoint}${azurerm_storage_container.stor-cnt.name}"
}

output "storage_name" {
  value = "${azurerm_storage_account.stor-dev.name}"
}

output "storage_account_key" {
  value = "${azurerm_storage_account.stor-dev.primary_access_key}"
}