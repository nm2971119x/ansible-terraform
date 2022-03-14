## K8S Master : Reglas de inbound y puertos que aceptan conexiones
resource "azurerm_network_security_group" "masterSecGroup" {
    name                = "masterports"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name                       = "ListPorts"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "TCP"
        source_port_range          = "*"
        destination_port_ranges     = [22,80,443,6443]
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "CP2"
    }
}

resource "azurerm_network_interface_security_group_association" "masterSecGroupAssociation" {
    network_interface_id      = azurerm_network_interface.myPublicIP1.id
    network_security_group_id = azurerm_network_security_group.masterSecGroup.id

}

## K8S Node : Reglas de inbound y puertos que aceptan conexiones
resource "azurerm_network_security_group" "worker1SecGroup" {
    name                = "worker1ports"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name                       = "ListPorts"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "TCP"
        source_port_range          = "*"
        destination_port_ranges     = [22,6443]
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "CP2"
    }
}

resource "azurerm_network_interface_security_group_association" "worker1SecGroupAssociation" {
    network_interface_id      = azurerm_network_interface.myPublicIP2.id
    network_security_group_id = azurerm_network_security_group.worker1SecGroup.id

}

## NFS Server - Aceptamos para NFS UDP y TCP solo desde la Intranet
resource "azurerm_network_security_group" "nfs2SecGroup" {
    name                = "nfs2ports"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name                       = "ListPorts"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "TCP"
        source_port_range          = "*"
        destination_port_ranges    = [22,111]
        source_address_prefix      = "10.0.0.0/24"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "ListPortsUDP"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "UDP"
        source_port_range          = "*"
        destination_port_ranges    = [2049]
        source_address_prefix      = "10.0.0.0/24"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "CP2"
    }
}

resource "azurerm_network_interface_security_group_association" "worker2SecGroupAssociation" {
    network_interface_id      = azurerm_network_interface.myPublicIP3.id
    network_security_group_id = azurerm_network_security_group.worker2SecGroup.id
}