resource "azurerm_monitor_diagnostic_setting" "aks" {
  name               = "aks-diag"
  target_resource_id = azurerm_kubernetes_cluster.aks.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.monitoring.id

  metric {
    category = "AllMetrics"
    enabled  = true
  }

  log {
    category = "kube-apiserver"
    enabled  = true
  }

  log {
    category = "kube-controller-manager"
    enabled  = true
  }
}

resource "azurerm_monitor_diagnostic_setting" "acr" {
  name               = "acr-diag"
  target_resource_id = azurerm_container_registry.acr.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.monitoring.id

  log {
    category = "ContainerRegistryLoginEvents"
    enabled  = true
  }

  log {
    category = "ContainerRegistryPush"
    enabled  = true
  }
}

resource "azurerm_monitor_metric_alert" "cpu" {
  name                = "${var.prefix}-cpu-alert"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_kubernetes_cluster.aks.id]
  description         = "Alert when AKS CPU usage exceeds threshold"
  severity            = 2
  enabled             = true
  frequency           = "PT5M"
  window_size         = "PT15M"

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "cpuUsagePercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.alerts.id
  }
}
