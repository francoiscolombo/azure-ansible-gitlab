data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {

  name                   = "${var.keyvault_name}"
  resource_group_name    = "${var.resource_group}"
  location               = "${var.location}"
  tenant_id              = "${data.azurerm_client_config.current.tenant_id}"

  enabled_for_deployment = true

  sku {
    name = "standard"
  }

  access_policy {
    tenant_id = "${data.azurerm_client_config.current.tenant_id}"
    object_id = "${data.azurerm_client_config.current.service_principal_object_id}"

    certificate_permissions = [
      "create","delete","deleteissuers",
      "get","getissuers","import","list",
      "listissuers","managecontacts","manageissuers",
      "setissuers","update",
    ]

    key_permissions = [
      "backup","create","decrypt","delete","encrypt","get",
      "import","list","purge","recover","restore","sign",
      "unwrapKey","update","verify","wrapKey",
    ]

    secret_permissions = [
      "backup","delete","get","list","purge","recover","restore","set",
    ]
  }

  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices"
  }

  tags {
    environment="${var.environment}"
  }

}

resource "azurerm_key_vault_certificate" "generated-cert" {

  name      = "${var.ssl_certificate_name}"
  vault_uri = "${azurerm_key_vault.keyvault.vault_uri}"

  certificate_policy {

    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {

      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = 30
      }

    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]

      subject_alternative_names {
        dns_names = ["keyteo-gitlab.westeurope.cloudapp.azure.com"]
      }

      subject            = "CN=keyteo-gitlab.westeurope.cloudapp.azure.com"
      validity_in_months = 12
    }

  }

}
