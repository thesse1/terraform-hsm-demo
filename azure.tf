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

    key_permissions = ["Get","List","Update","Create","Import","Delete","Recover","Backup","Restore","Decrypt","Encrypt","UnwrapKey","WrapKey","Verify","Sign","Purge","Release","Rotate","GetRotationPolicy","SetRotationPolicy"]
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

    key_permissions = ["Get","List","Update","Create","Import","Delete","Recover","Backup","Restore","Decrypt","Encrypt","UnwrapKey","WrapKey","Verify","Sign","Purge","Release","Rotate","GetRotationPolicy","SetRotationPolicy"]
  }
}