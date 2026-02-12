variable "azure_user_id" {}

resource "azurerm_key_vault" "thes_kv_germanywestcentral" {
  name                       = "thes-kv-germanywestcentr"
  location                   = "germanywestcentral"
  resource_group_name        = "thes-hsm"
  tenant_id                  = var.azure_tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = var.azure_tenant_id
    object_id = var.azure_object_id

    key_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
  }

  access_policy {
    tenant_id = var.azure_tenant_id
    object_id = var.azure_user_id

    key_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
  }
}

resource "azurerm_key_vault" "thes_kv_westeurope" {
  name                       = "thes-kv-westeurope"
  location                   = "westeurope"
  resource_group_name        = "thes-hsm"
  tenant_id                  = var.azure_tenant_id
  sku_name                   = "premium"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = var.azure_tenant_id
    object_id = var.azure_object_id

    key_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
  }

  access_policy {
    tenant_id = var.azure_tenant_id
    object_id = var.azure_user_id

    key_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt", "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
  }
}

data "azurerm_key_vault_key" "thes_key_germanywestcentral" {
  count = 2
  name         = "thes-key-${count.index + 1}"
  key_vault_id = azurerm_key_vault.thes_kv_germanywestcentral.id

  depends_on = [ ibm_hpcs_managed_key.managed_key ]
}

data "azurerm_key_vault_key" "thes_key_westeurope" {
  count = 2
  name         = "thes-key-${count.index + 1}"
  key_vault_id = azurerm_key_vault.thes_kv_westeurope.id

  depends_on = [ ibm_hpcs_managed_key.managed_key ]
}

output "azure_keys_germanywestcentral" {
  value = data.azurerm_key_vault_key.thes_key_germanywestcentral
}

output "azure_keys_westeurope" {
  value = data.azurerm_key_vault_key.thes_key_westeurope
}