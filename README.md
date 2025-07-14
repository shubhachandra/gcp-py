locals {
  existing_service_accounts = [
    for key, sa in data.google_service_account.service_agents :
    sa.email
    if !sa.managed_by.empty # workaround: assume if it's managed it's real
  ]
}
