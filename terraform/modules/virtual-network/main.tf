resource "azurerm_virtual_network" "vnet" {

  name                = "${var.virtual_network_name}"
  location            = "${var.location}"
  address_space       = ["${var.vnet_address_space}"]
  resource_group_name = "${var.resource_group}"

  tags {
    environment = "${var.environment}"
  }

}
