data "google_service_account" "service_agents" {
  for_each = { for api, email in local.apis : api => email if contains(var.wf_cm_active_apis, api) }

  account_id = each.value
  project    = var.wf_cm_service_project_id
}
