resource "google_compute_subnetwork_iam_member" "core_subnet_access" {
  for_each = {
    for subnet_link in local.default_networks["core"] : subnet_link => {
      project = local.default_host_projects["core"]
      region  = split("/", subnet_link)[4]
      name    = split("/", subnet_link)[6]
    }
  }

  project = each.value.project
  region  = each.value.region
  subnetwork = each.value.name
  role    = "roles/compute.networkUser"
  member  = local.subnet_access_groups["core"]
}
