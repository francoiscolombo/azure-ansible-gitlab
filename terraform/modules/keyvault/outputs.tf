output "certificate" {
  value = "${azurerm_key_vault_certificate.generated-cert.certificate_data}"
}

output "certificate_thumbprint" {
    value = "${azurerm_key_vault_certificate.generated-cert.thumbprint}"
}

output "vault_id" {
  value = "${azurerm_key_vault.keyvault.id}"
}

output "vault_certificate_id" {
  value = "${azurerm_key_vault_certificate.generated-cert.id}"
}