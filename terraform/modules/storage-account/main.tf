resource "azurerm_storage_account" "stor-dev" {

  name                     = "${var.storage_account_name}"
  location                 = "${var.location}"
  resource_group_name      = "${var.resource_group}"
  account_replication_type = "${var.storage_account_type}"
  account_tier             = "${var.storage_account_tier}"

  tags {
    environment="${var.environment}"
  }

}

resource "azurerm_storage_container" "stor-cnt" {

  name                  = "${var.storage_container_name}"
  resource_group_name   = "${var.resource_group}"
  storage_account_name  = "${azurerm_storage_account.stor-dev.name}"
  container_access_type = "private"

}
