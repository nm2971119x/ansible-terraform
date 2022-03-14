# K8S Master - HD
resource "azurerm_managed_disk" "k8s-master-disk" {
  name                 = "k8s-master-disk"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 8
}
# K8S Worker - HD
resource "azurerm_managed_disk" "k8s-node1-disk" {
  name                 = "k8s-node1-disk"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 8
}
# NFS Server - HD
resource "azurerm_managed_disk" "nfs-server-disk" {
  name                 = "nfs-server-disk"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 20
}
