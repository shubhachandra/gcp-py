locals {
  existing_service_accounts = [
    for key, sa in data.google_service_account.service_agents :
    sa.email
    if !sa.managed_by.empty # workaround: assume if it's managed it's real
  ]
}


locals {
  existing_service_accounts = [
    for key, sa in data.google_service_account.service_agents :
    sa.email
    if try(sa.email, null) != null
  ]
}


resource "google_cloud_identity_group_membership" "service_account_subnet_group_membership" {
  count = var.wf_cm_grant_network_role && local.subnet_group_id != null ? length(local.existing_service_accounts) : 0

  group = "groups/${local.subnet_group_id}"

  preferred_member_key {
    id = local.existing_service_accounts[count.index]
  }

  roles {
    name = "MEMBER"
  }
}
