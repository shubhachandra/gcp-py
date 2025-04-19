resource "google_cloudidentity_group_membership" "service_account_membership" {
  for_each = local.apis  # or toset(local.active_apis) if you prefer

  group = "groups/gcp_gcp_core_subnetwork_sa@wells.com"  # Replace with your group's email

  preferred_member_key {
    id = format("serviceAccount:%s", each.value)  # e.g. serviceAccount:service-<project_number>@...
  }

  roles {
    name = "MEMBER"
  }
}
