variable "token" {}

resource "ibm_hpcs" "hpcs" {
  location             = "eu-de"
  name                 = "thes-hpcs"
  plan                 = "hpcs-hourly-uko"
  units                = 2
  signature_threshold  = 1
  revocation_threshold = 1
  resource_group_id    = "21d0ae22e3394e2299c87975244aefd4"
  admins {
    name  = "admin1"
    key   = "C:\\tke-files\\1.sigkey"
    token = var.token
  }
}

locals {
  hpcs_id = element(split(":", ibm_hpcs.hpcs.id), 7)
}

resource "ibm_hpcs_vault" "vault" {
  instance_id = local.hpcs_id
  region      = ibm_hpcs.hpcs.location
  name        = "thes-vault"
}

locals {
  vault_id = element(split("/", ibm_hpcs_vault.vault.id), 2)
}

variable "azure_service_principal_client_id" {}
variable "azure_service_principal_password" {}
variable "azure_tenant_id" {}
variable "azure_subscription_id" {}
variable "azure_object_id" {}

resource "ibm_hpcs_keystore" "azure_keystore_germanywestcentral" {
  instance_id = local.hpcs_id
  region      = ibm_hpcs.hpcs.location
  uko_vault   = local.vault_id
  type        = "azure_key_vault"
  vault {
    id = local.vault_id
  }
  name                              = "thes-azure-keystore-germanywestcentral"
  groups                            = ["Production-Azure"]
  azure_resource_group              = "thes-hsm"
  azure_location                    = "germanywestcentral"
  azure_service_principal_client_id = var.azure_service_principal_client_id
  azure_service_principal_password  = var.azure_service_principal_password
  azure_tenant                      = var.azure_tenant_id
  azure_subscription_id             = var.azure_subscription_id
  azure_environment                 = "azure"
  azure_service_name                = "thes-kv-germanywestcentr"

  lifecycle {
    ignore_changes = [azure_service_principal_password]
  }

  depends_on = [azurerm_key_vault.thes_kv_germanywestcentral]
}

resource "ibm_hpcs_keystore" "azure_keystore_westeurope" {
  instance_id = local.hpcs_id
  region      = ibm_hpcs.hpcs.location
  uko_vault   = local.vault_id
  type        = "azure_key_vault"
  vault {
    id = local.vault_id
  }
  name                              = "thes-azure-keystore-westeurope"
  groups                            = ["Production-Azure"]
  azure_resource_group              = "thes-hsm"
  azure_location                    = "europe_west"
  azure_service_principal_client_id = var.azure_service_principal_client_id
  azure_service_principal_password  = var.azure_service_principal_password
  azure_tenant                      = var.azure_tenant_id
  azure_subscription_id             = var.azure_subscription_id
  azure_environment                 = "azure"
  azure_service_name                = "thes-kv-westeurope"

  lifecycle {
    ignore_changes = [azure_service_principal_password]
  }

  depends_on = [azurerm_key_vault.thes_kv_westeurope]
}

resource "ibm_hpcs_key_template" "key_template" {
  instance_id = local.hpcs_id
  region      = ibm_hpcs.hpcs.location
  uko_vault   = local.vault_id
  vault {
    id = local.vault_id
  }
  name = "thes-key-template"
  key {
    size            = "2048"
    algorithm       = "rsa"
    activation_date = "P0D"
    expiration_date = "P1Y"
    state           = "active"
  }
  keystores {
    group = "Production-Azure"
    type  = "azure_key_vault"
  }
}

resource "ibm_hpcs_managed_key" "managed_key" {
  count       = 2
  instance_id = local.hpcs_id
  region      = ibm_hpcs.hpcs.location
  uko_vault   = local.vault_id
  vault {
    id = local.vault_id
  }
  label         = "thes-key-${count.index + 1}"
  template_name = ibm_hpcs_key_template.key_template.name
}

# resource "ibm_iam_user_policy" "policy" {
#   ibm_id = "thomas.hesse2@ibm.com"
#   roles  = ["Administrator"]

#   resources {
#     service              = "thes-hpcs"
#     resource_instance_id = element(split(":", ibm_hpcs.hpcs.id), 7)
#   }
# }