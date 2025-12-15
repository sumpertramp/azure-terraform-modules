# Azure Virtual Machine Terraform Module (Linux & Windows)

## Overview

This repository provides a reusable, production-ready Terraform module for provisioning Azure Virtual Machines.
The module supports both Linux and Windows VMs, selected dynamically based on user input.

It is designed according to real-world DevOps and CI/CD best practices and can be reused across multiple projects and clients.

---

## Problem Statement

Provisioning Azure Virtual Machines repeatedly often leads to:

- Duplicated Terraform code
- Manual configuration mistakes
- Inconsistent VM sizes, regions, and OS selections
- Poor reusability in CI/CD pipelines

---

## Solution

This Terraform module provides:

- A single module for both Linux and Windows VMs
- Fully parameterized configuration
- Input validation to prevent misconfiguration
- Clear separation between module code and root/example configurations
- Easy integration with CI/CD pipelines

---

## Module Features

- Linux or Windows VM creation (user-selected)
- Configurable VM size and Azure region
- Secure authentication:
  - SSH key for Linux
  - Password for Windows
- Built-in networking (VNet, Subnet, NIC)
- Resource tagging support
- CI/CD and pipeline friendly design

---

## Repository Structure
```text
azure-terraform-modules/
├── modules/
│   └── compute/
│       └── virtual-machine/
│           ├── main.tf
│           ├── variables.tf
│           ├── outputs.tf
│           └── README.md
│
├── examples/
│   ├── linux-vm/
│   │   └── main.tf
│   └── windows-vm/
│       └── main.tf
```

## Example Usage

### Linux Virtual Machine
```hcl
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
    os          = "linux"
  }
}
```
---

### Windows Virtual Machine
```hcl
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
    os          = "windows"
  }
}
```
---

## Input Variables

| Variable | Description |
|--------|-------------|
| `vm_name` | Name of the virtual machine (required) |
| `location` | Azure region (required) |
| `vm_size` | Azure VM size (required) |
| `os_type` | linux or windows (required) |
| `admin_username` | Admin username (required) |
| `ssh_public_key` | SSH public key (Linux only) |
| `admin_password` | Admin password (Windows only) |
| `tags` | Resource tags (optional) |

---

## Outputs

| Output | Description |
|------|-------------|
| `vm_id` | ID of the created virtual machine |
| `vm_name` | Name of the VM |
| `private_ip` | Private IP address |
| `resource_group_name` | Resource group name |
| `location` | Azure region |
| `os_type` | Selected operating system |

---

## Security Considerations

- Sensitive values such as passwords and SSH keys are not exposed as outputs
- OS-specific input validation prevents invalid deployments
- Designed to integrate with Azure Key Vault in CI/CD pipelines

---

## Real-World Use Cases

- CI/CD pipelines provisioning ephemeral environments
- Dev/Test VM automation on Azure
- Client infrastructure deployments
- Reusable Terraform modules for consulting and freelance projects
- Upwork and contract-based DevOps engagements

---

## Design Principles

- One module, one responsibility
- Behavior controlled entirely by inputs
- No hardcoded environment-specific values
- CI/CD-friendly structure
- Production-oriented Terraform patterns

---

## Future Improvements

- Azure Storage backend configuration
- Azure DevOps CI/CD pipeline examples
- Azure Key Vault integration
- Optional Public IP or Azure Bastion support

---

## Author

DevOps Engineer  
Terraform | Azure | CI/CD
