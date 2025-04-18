resource "google_compute_subnetwork_iam_member" "subnet_group_access" {
  provider = google-beta

  for_each = {
    for subnet_link in local.default_networks["core"] : subnet_link => {
      region = split("/", subnet_link)[3]
      name   = split("/", subnet_link)[5]
      project = local.default_host_projects["core"]
    }
  }

  project    = each.value.project
  region     = each.value.region
  subnetwork = each.value.name
  role       = "roles/compute.networkUser"
  member     = local.subnet_access_groups["core"]
}
