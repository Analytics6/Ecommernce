data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "main" {
  name                        = "${var.prefix}-vault"
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = false
  soft_delete_enabled         = true
  soft_delete_retention_days  = 14
  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
  tags = {
    environment = "production"
    project     = "ecommernce"
  }
}

resource "azurerm_key_vault_secret" "db_connection" {
  name         = "DbConnectionString"
  value        = "Server=${azurerm_sql_server.main.fully_qualified_domain_name};Database=${azurerm_sql_database.main.name};User ID=${var.sql_admin_username};Password=${var.sql_admin_password};Encrypt=true;TrustServerCertificate=false;Connection Timeout=30;"
  key_vault_id = azurerm_key_vault.main.id
}

resource "azurerm_key_vault_secret" "payment_key" {
  name         = "PaymentProviderKey"
  value        = var.payment_provider_key
  key_vault_id = azurerm_key_vault.main.id
}
