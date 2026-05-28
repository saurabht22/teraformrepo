resource "azurerm_resource_group" "ComputeRG" {
    name = var.resource_group_name
    location = var.location
}
resource "azurerm_virtual_network" "vnet1" {
    name = var.vnet_name
    location = var.location
    resource_group_name = var.resource_group_name
    address_space = [ "10.0.0.0/16" ]
}

resource "azurerm_subnet" "subnet1" {
    name = var.subnet_name
    virtual_network_name = var.vnet_name
    resource_group_name = var.resource_group_name
    address_prefixes = [ "10.0.1.0/24" ]
}

resource "azurerm_network_interface" "nic" {
    name = "${var.vm_name}-nic1"
    location = var.location
    resource_group_name = var.resource_group_name
    ip_configuration {
      name = "pvt_ip"
      subnet_id = azurerm_subnet.subnet1.id
      private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_storage_account" "storage" {
    name = var.storage_account_name
    resource_group_name = azurerm_resource_group.ComputeRG.id
    location = azurerm_resource_group.ComputeRG.location
    account_tier = "Standard"
    account_replication_type = "LRS"
    public_network_access_enabled = true
}


resource "azurerm_linux_virtual_machine" "VM1" {
    name = var.vm_name
    resource_group_name = var.resource_group_name
    location = var.location
    size = var.vm_size
    admin_username = var.username
    admin_password = var.password
    disable_password_authentication = false
    network_interface_ids = [ azurerm_network_interface.nic.id ]
    os_disk {
      caching = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference {
      publisher = "Canonical"
      offer = "0001-com-ubuntu-server-jammy"
      sku = "22_04-lts"
      version = "latest"
    }
  
}
