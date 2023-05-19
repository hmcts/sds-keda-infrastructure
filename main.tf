resource "azurerm_user_assigned_identity" "managed_identity" {

  resource_group_name = "managed-identities-${var.env}-rg"
  location            = var.location

  name = "${var.product}-${var.env}-mi"

  tags = var.common_tags
}

locals {
  mgmt_env = ( var.env == "ptlsbox") ? "sdssbox-intsvc" : "sdsptl-intsvc"
}

resource "azurerm_user_assigned_identity" "mgmt_managed_identity" {

  count = (var.env == "ptlsbox" || var.env == "ptl" ) ? 1 : 0

  provider = azurerm.mgmt

  resource_group_name = "managed-identities-${local.mgmt_env}-rg"
  location            = var.location

  name = "${var.product}-${local.mgmt_env}-mi"

  tags = var.common_tags
}