provider "azurerm" {
  features {}
}

module "vm" {
  source = "../../modules/compute/virtual-machine"

  vm_name        = "test-linux-vm"
  location       = "westeurope"
  vm_size        = "Standard_B2s"
  os_type        = "linux"

  admin_username = "azureuser"
  ssh_public_key = file("~/.ssh/id_rsa.pub")

  tags = {
    environment = "test"
    project     = "terraform-azure-modules"
    os          = "linux"
  }
}
