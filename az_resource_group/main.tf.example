locals {
  # Prefix will be used for creating resource names so that they are unique.
  prefix   = ""
  location = "East US"
  # Tags for created resources
  tags = {
    owner        = ""
    OwnerContact = ""
    TTL          = "DO-NOT-DELETE"
  }
  # Source address prefix list which is allowed to connect to resources.
  source_address_prefix = ["x.x.x.x/32"]
}

module "resource_group" {
  source          = "../modules/az_resource_group"
  name            = "${local.prefix}-rg"
  resource_prefix = local.prefix
  location        = local.location
  tags            = local.tags
}

module "vnet" {
  source                = "../modules/az_vnet"
  rg_name               = "${local.prefix}-rg"
  resource_prefix       = local.prefix
  location              = local.location
  source_address_prefix = local.source_address_prefix
  tags                  = local.tags
}
