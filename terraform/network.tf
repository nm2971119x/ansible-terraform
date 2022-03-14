## Definimos en qué tipo de red estarán las VMS alojadas

resource "azurerm_virtual_network" "myNet" {
    name                = "k8snet"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    tags = {
        environment = "CP2"
    }
}

## Definimos la subred que tendrá las nics configurada

resource "azurerm_subnet" "mySubnet" {
    name                   = "k8subnet"
    resource_group_name    = azurerm_resource_group.rg.name
    virtual_network_name   = azurerm_virtual_network.myNet.name
    address_prefixes       = ["10.0.1.0/24"]

}

## IP Intranet k8s-master
resource "azurerm_network_interface" "myPublicIP1" {
  name                = "vmnic1"  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "myipconfiguration1"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = var.master_ip_intranet
    public_ip_address_id           = azurerm_public_ip.myPublicIP1.id
  }

    tags = {
        environment = "CP2"
    }

}

## IP Intranet k8s-node
resource "azurerm_network_interface" "myPublicIP2" {
  name                = "vmnic2"  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "myipconfiguration1"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = var.node1_ip_intranet
    public_ip_address_id           = azurerm_public_ip.myPublicIP2.id
  }

    tags = {
        environment = "CP2"
    }

}

## IP Intranet NFS Server
resource "azurerm_network_interface" "myPublicIP3" {
  name                = "vmnic3"  
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
    name                           = "myipconfiguration1"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = var.nfs_ip_intranet
    public_ip_address_id           = azurerm_public_ip.myPublicIP3.id
  }

    tags = {
        environment = "CP2"
    }

}

## IP Publica k8s-master
resource "azurerm_public_ip" "myPublicIP1" {
  name                = "vmip1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        environment = "CP2"
    }

}

## IP Publica para k8s-node1
resource "azurerm_public_ip" "myPublicIP2" {
  name                = "vmip2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        environment = "CP2"
    }

}

## IP Publica para nfs-server
resource "azurerm_public_ip" "myPublicIP3" {
  name                = "vmip3"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

    tags = {
        environment = "CP2"
    }

}