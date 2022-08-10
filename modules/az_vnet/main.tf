data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.resource_prefix}-nsg"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource_prefix}-vnet"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.vnet_address_space

  subnet {
    name           = "${var.resource_prefix}-subnet-default"
    address_prefix = var.vnet_subnet_address_prefix
    security_group = azurerm_network_security_group.nsg.id
  }

  tags = var.tags
}

resource "azurerm_network_security_rule" "ssh" {
  count                       = length(var.source_address_prefix)
  name                        = "ssh-inbound-${count.index}"
  priority                    = 100 + count.index
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = element(var.source_address_prefix, count.index)
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "ghes" {
  count                       = length(var.source_address_prefix)
  name                        = "ghes-inbound-${count.index}"
  priority                    = 200 + count.index
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "122"
  source_address_prefix       = element(var.source_address_prefix, count.index)
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "winrm_http" {
  count                       = length(var.source_address_prefix)
  name                        = "winrm-http-inbound-${count.index}"
  priority                    = 300 + count.index
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5985"
  source_address_prefix       = element(var.source_address_prefix, count.index)
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "winrm_https" {
  count                       = length(var.source_address_prefix)
  name                        = "winrm-https-inbound-${count.index}"
  priority                    = 400 + count.index
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5986"
  source_address_prefix       = element(var.source_address_prefix, count.index)
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "rdp" {
  count                       = length(var.source_address_prefix)
  name                        = "winrm-rdp-inbound-${count.index}"
  priority                    = 500 + count.index
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = element(var.source_address_prefix, count.index)
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}
