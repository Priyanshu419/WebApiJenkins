provider "azurerm" {
  features {}

  subscription_id = "39007855-6a12-4f14-ac77-13c3310b2789"
  tenant_id       = "f56c6c65-c045-4485-9192-aa84a2951b0e"
}

resource "azurerm_resource_group" "rg" {
  name     = "codecraft-rg"
  location = "East US"
}

resource "azurerm_container_registry" "acr" {
  name                = "codecraftacr123"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = false
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "codecraft-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "codecraft"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  role_based_access_control {
    enabled = true
  }

  depends_on = [azurerm_container_registry.acr]
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity.object_id
}

