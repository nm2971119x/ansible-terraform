## VM k8s-master, nodo master del cluster k8s
resource "azurerm_linux_virtual_machine" "k8s-master" {
    name                = "k8s-master"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = var.vm_size_2cores
    admin_username      = "lab"
    network_interface_ids = [ azurerm_network_interface.myPublicIP1.id ]
    disable_password_authentication = true

    admin_ssh_key {
        username   = var.ssh_user
        public_key = file(var.public_key_path)
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = var.vm_image_publisher
        offer     = var.vm_image_offer
        sku       = var.vm_image_sku
        version   = var.vm_image_version
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stAccount.primary_blob_endpoint
    }

    tags = {
        environment = "CP2"
    }

}

## VM k8s-worker, worker del cluster k8s
resource "azurerm_linux_virtual_machine" "k8s-node1" {
    name                = "k8s-node1"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = var.vm_size_1core
    admin_username      = "lab"
    network_interface_ids = [ azurerm_network_interface.myPublicIP2.id ]
    disable_password_authentication = true

    admin_ssh_key {
        username   = var.ssh_user
        public_key = file(var.public_key_path)
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = var.vm_image_publisher
        offer     = var.vm_image_offer
        sku       = var.vm_image_sku
        version   = var.vm_image_version
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stAccount.primary_blob_endpoint
    }

    tags = {
        environment = "CP2"
    }
}

## VM nfs-server
resource "azurerm_linux_virtual_machine" "nfs-server" {
    name                = "nfs-server"
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
    size                = var.vm_size_1core
    admin_username      = "lab"
    network_interface_ids = [ azurerm_network_interface.myPublicIP3.id ]
    disable_password_authentication = true

    admin_ssh_key {
        username   = var.ssh_user
        public_key = file(var.public_key_path)
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = var.vm_image_publisher
        offer     = var.vm_image_offer
        sku       = var.vm_image_sku
        version   = var.vm_image_version
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.stAccount.primary_blob_endpoint
    }

    tags = {
        environment = "CP2"
    }
}
