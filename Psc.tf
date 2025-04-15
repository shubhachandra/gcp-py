resource "google_compute_service_attachment" "google_apis" {
  name                  = "google-apis-psc"
  project               = var.project_id
  region                = var.region
  enable_proxy_protocol = false

  connection_preference = "ACCEPT_MANUAL"  # Manual acceptance
  nat_subnets           = [var.subnet_self_link]
  target_service        = "projects/cloud-global/regions/${var.region}/serviceAttachments/google-apis"
  description           = "PSC endpoint for Google APIs with manual connection approval"
}
