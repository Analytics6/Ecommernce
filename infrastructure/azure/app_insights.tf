resource "azurerm_application_insights" "app" {
  name                = "${var.prefix}-appinsights"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  application_type    = "web"
  retention_in_days   = 30
  sampling_percentage = 100
  tags = {
    environment = "production"
    project     = "ecommernce"
  }
}

resource "azurerm_monitor_action_group" "alerts" {
  name                = "${var.prefix}-alerts"
  resource_group_name = azurerm_resource_group.main.name
  short_name          = "EcomAlerts"

  email_receiver {
    name                    = "oncall"
    email_address           = "ops@example.com"
    use_common_alert_schema = true
  }
}
