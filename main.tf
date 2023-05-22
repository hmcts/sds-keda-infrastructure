resource "azurerm_user_assigned_identity" "managed_identity" {

  resource_group_name = "managed-identities-${var.env}-rg"
  location            = var.location

  name = "${var.product}-${var.env}-mi"
  tags = var.common_tags
}

locals {
  mgmt_env = ( var.env == "sandbox") ? "sdssbox-intsvc" : "sdsptl-intsvc"
  rg_name = var.env == "sandbox" ? "ptlsbox" : "ptl"
}

resource "azurerm_user_assigned_identity" "mgmt_managed_identity" {

  count = (var.env == "sandbox" || var.env == "prod" ) ? 1 : 0

  provider = azurerm.mgmt

  resource_group_name = "managed-identities-${local.rg_name}-rg"
  location            = var.location

  name = "${var.product}-${local.mgmt_env}-mi"

  tags = var.common_tags
}
