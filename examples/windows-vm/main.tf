provider "azurerm" {
  features {}
}

module "vm" {
  source = "../../modules/compute/virtual-machine"

  vm_name        = "test-win-vm"
  location       = "westeurope"
  vm_size        = "Standard_B2s"
  os_type        = "windows"

  admin_username = "azureuser"
  admin_password = "P@ssw0rd1234!"

  tags = {
    environment = "test"
    project     = "terraform-azure-modules"
  }
}
