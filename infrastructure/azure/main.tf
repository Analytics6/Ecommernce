resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_log_analytics_workspace" "monitoring" {
  name                = "${var.prefix}-law"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Premium"
  admin_enabled       = false
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "${var.prefix}-aks"
  kubernetes_version  = "1.28.14"

  default_node_pool {
    name                = "agentpool"
    vm_size             = var.vm_size
    node_count          = var.node_count
    min_count           = var.min_count
    max_count           = var.max_count
    enable_auto_scaling = true
    type                = "VirtualMachineScaleSets"
    vnet_subnet_id      = null
    os_disk_size_gb     = 100
    max_pods            = 110
    enable_node_public_ip = false
  }

  network_profile {
    network_plugin    = "kubenet"
    network_policy    = "azure"
    load_balancer_sku = "standard"
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control {
    enabled = true
  }

  addon_profile {
    kube_dashboard {
      enabled = false
    }

    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.monitoring.id
    }
  }

  linux_profile {
    admin_username = "azureuser"
    ssh_key {
      key_data = var.ssh_public_key
    }
  }

  tags = {
    environment = "production"
    project     = "ecommernce"
  }
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}
