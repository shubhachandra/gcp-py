variable "lookup_project_numbers" {
  type = bool
}

variable "service_project_id" {
  type = string
}

variable "service_project_number" {
  type = string
}

data "google_project" "service_project" {
  count      = var.lookup_project_numbers ? 1 : 0
  project_id = var.service_project_id
}

# Step 1: Derive the service project number
locals {
  service_project_number = var.lookup_project_numbers ? data.google_project.service_project[0].number : var.service_project_number

  # Step 2: Define all possible service agent mappings
  all_apis = {
    "container.googleapis.com"         = format("service-%s@container-engine-robot.iam.gserviceaccount.com",        local.service_project_number)
    "dataproc.googleapis.com"          = format("service-%s@dataproc-accounts.iam.gserviceaccount.com",             local.service_project_number)
    "dataflow.googleapis.com"          = format("service-%s@dataflow-service-producer-prod.iam.gserviceaccount.com",local.service_project_number)
    "datafusion.googleapis.com"        = format("service-%s@gcp-sa-datafusion.iam.gserviceaccount.com",             local.service_project_number)
    "composer.googleapis.com"          = format("service-%s@cloudcomposer-accounts.iam.gserviceaccount.com",        local.service_project_number)
    "vpcaccess.googleapis.com"         = format("service-%s@gcp-sa-vpcaccess.iam.gserviceaccount.com",              local.service_project_number)
    "datastream.googleapis.com"        = format("service-%s@gcp-sa-datastream.iam.gserviceaccount.com",             local.service_project_number)
    "notebooks.googleapis.com"         = format("service-%s@gcp-sa-notebooks.iam.gserviceaccount.com",              local.service_project_number)
    "networkconnectivity.googleapis.com" = format("service-%s@gcp-sa-networkconnectivity.iam.gserviceaccount.com",  local.service_project_number)
  }
}

# Step 3: Lookup each service account (if it exists)
data "google_service_account" "agents" {
  for_each   = local.all_apis
  account_id = each.value
  project    = var.service_project_id
}

# Step 4: Filter only the APIs with existing service agents
locals {
  apis = {
    for api, sa_email in local.all_apis :
    api => sa_email
    if try(data.google_service_account.agents[api].email, null) != null
  }
}

# Optional: Output to verify
output "filtered_existing_apis" {
  value = local.apis
}
