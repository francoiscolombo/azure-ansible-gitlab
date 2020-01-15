subscription_id="xxx"
tenant_id="xxx"

client_id="xxx"
client_secret="xxx"

admin_username  = "admgitlab"
ssh_public_key  = "xxx admgitlab@azure"
ssh_key_private = "../ansible/admgitlab.rsa"

environment    = "keyteo.azure.gitlab"
location       = "West Europe"
resource_group = "keyteo-azure-gitlab-rg"
name_prefix    = "keyteo-azure-gitlab"

vnet_address_space   = "10.10.0.0/16"
subnet_address_space = "10.10.10.0/24"

storage_account_type = "LRS"
storage_account_tier = "Standard"
storage_account_name = "keyteoazuregitlab"

image_publisher = "Canonical"
image_offer     = "UbuntuServer"
image_sku       = "18.04-LTS"
image_version   = "latest"

ansible_playbook = "../ansible/gitlab-playbook.yml"
ansible_platform = "../ansible/platform.yml"
