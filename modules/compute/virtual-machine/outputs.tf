output "vm_id" {
  description = "ID of the provisioned virtual machine"

  value = (
    var.os_type == "linux"
    ? azurerm_linux_virtual_machine.this[0].id
    : azurerm_windows_virtual_machine.this[0].id
  )
}

output "vm_name" {
  description = "Name of the virtual machine"
  value       = var.vm_name
}

output "private_ip" {
  description = "Private IP address of the VM"
  value       = azurerm_network_interface.this.private_ip_address
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.this.name
}

output "location" {
  description = "Azure region where the VM is deployed"
  value       = var.location
}

output "os_type" {
  description = "Operating system type of the VM"
  value       = var.os_type
}
