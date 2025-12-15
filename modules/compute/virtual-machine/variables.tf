variable "vm_name" {
    description = "Name of the virtual machine"
    type = string
}

variable "location" {
    description = "Azure region where resources will be created"
    type = string
}

variable "vm_size" {
    description = "Selecting Azure VM size"
    type = string
}

variable "os_type" {
    description = "Operation system type: linux or windows"
    type = string
    validation {
        condition = contains(["linux", "windows"], var.os_type)
        error_message = "os_type must be either 'linux' or 'windows'."
    }
}

variable "admin_username" {
    description = "Admin username for the virtual machine"
    type = string
}

variable "ssh_public_key" {
    description = "SSH public key for Linux VM"
    type = string
    default = null

    validation {
        condition = var.os_type != "linux" || var.ssh_public_key != null
        error_message = "ssh_public_key is required when os_type is linux."
    }
}

variable "admin_password" {
    description = "Admin password for the virtual machine"
    type = string
    default = null

    validation {
        condition = var.os_type != "windows" || var.admin_password != null
        error_message = "admin_password is required when os_type is windows."
    }
}

variable "tags" {
    description = "Tags to apply to resources"
    type = map(string)
    default = {}
}

