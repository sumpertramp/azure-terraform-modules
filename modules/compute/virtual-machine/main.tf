terraform {
    required_version = ">= 1.3"

    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 3.0"
        }
    }
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "this" {
    name = "${var.vm_name}-rg"
    location = var.location
    tags = var.tags
}

resource "azurerm_virtual_network" "this" {
    name = "${var.vm_name}-vnet"
    address_space = ["10.0.0.0/16"]
    location = var.location
    resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet" "this" {
    name = "default"
    resource_group_name = azurerm_resource_group.this.name
    virtual_network_name = azurerm_virtual_network.this.name
    address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "this" {
    name = "${var.vm_name}-nic"
    location = var.location
    resource_group_name = azurerm_resource_group.this.name

    ip_configuration {
        name = "internal"
        subnet_id = azurerm_subnet.this.id
        private_ip_address_allocation = "Dynamic"    
    }
}

resource "azurerm_linux_virtual_machine" "this" {
    count = var.os_type == "linux" ? 1 : 0
    name = var.vm_name
    location = var.location
    resource_group_name = azurerm_resource_group.this.name
    size = var.vm_size
    admin_username = var.admin_username

    network_interface_ids = [
        azurerm_network_interface.this.id
    ]

    admin_ssh_key {
        username = var.admin_username
        public_key = var.ssh_public_key
    }

    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer = "0001-com-ubuntu-server-focal"
        sku = "20_04-lts"
        version = "latest"
    }

    tags = var.tags
}

resource "azurerm_windows_virtual_machine" "this" {
    count = var.os_type == "windows" ? 1 : 0

    name = var.vm_name
    location = var.location
    resource_group_name = azurerm_resource_group.this.name
    size = var.vm_size

    admin_username = var.admin_username
    admin_password = var.admin_password

    network_interface_ids = [
        azurerm_network_interface.this.id
    ]

    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer = "WindowsServer"
        sku = "2019-Datacenter"
        version = "latest"
    }

    tags = var.tags
}

