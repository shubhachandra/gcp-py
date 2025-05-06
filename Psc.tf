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


variable "region" {
  default = "us-central1"
}

variable "producers" {
  description = "List of producer configurations"
  type = map(object({
    project_id = string
    vpc        = string
    subnet     = string
  }))
}

variable "consumers" {
  description = "List of consumer configurations"
  type = map(object({
    project_id    = string
    vpc           = string
    subnet        = string
    producer_name = string  # key from 'producers'
  }))
}
# Providers for each producer (using default provider)
provider "google" {
  project = var.producers[local.first_producer].project_id
  region  = var.region
}

locals {
  first_producer = keys(var.producers)[0]
}

# Backend services for each producer
resource "google_compute_region_backend_service" "backend" {
  for_each              = var.producers
  name                  = "${each.key}-backend"
  region                = var.region
  project               = each.value.project_id
  protocol              = "TCP"
  load_balancing_scheme = "INTERNAL"

  backend = []
}

resource "google_compute_forwarding_rule" "ilb" {
  for_each              = var.producers
  name                  = "${each.key}-ilb"
  region                = var.region
  project               = each.value.project_id
  network               = each.value.vpc
  subnetwork            = each.value.subnet
  ports                 = ["80"]
  backend_service       = google_compute_region_backend_service.backend[each.key].id
  load_balancing_scheme = "INTERNAL"
  ip_protocol           = "TCP"
}

resource "google_compute_service_attachment" "psc_attachment" {
  for_each              = var.producers
  name                  = "${each.key}-psc"
  project               = each.value.project_id
  region                = var.region
  target_service        = google_compute_forwarding_rule.ilb[each.key].self_link
  connection_preference = "ACCEPT_MANUAL"
  nat_subnets           = [each.value.subnet]

  dynamic "consumer_accept_lists" {
    for_each = {
      for cname, cdata in var.consumers :
      cname => cdata if cdata.producer_name == each.key
    }
    content {
      project_id_or_num = consumer_accept_lists.value.project_id
      connection_limit  = 10
    }
  }
}
# Define consumer providers dynamically
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
  }
}

provider "google" {
  alias   = "default"
  project = var.producers[local.first_producer].project_id
  region  = var.region
}

provider "google" {
  alias   = "consumer"
  project = var.consumers[local.first_consumer].project_id
  region  = var.region
}

locals {
  first_consumer = keys(var.consumers)[0]
}

resource "google_compute_service_connection" "psc_connection" {
  for_each = var.consumers

  provider           = google.consumer
  name               = "${each.key}-psc-connection"
  region             = var.region
  project            = each.value.project_id
  network            = each.value.vpc
  subnetwork         = each.value.subnet
  service_attachment = google_compute_service_attachment.psc_attachment[each.value.producer_name].id
}
producers = {
  producer1 = {
    project_id = "producer-project-1"
    vpc        = "vpc-producer-1"
    subnet     = "subnet-producer-1"
  },
  producer2 = {
    project_id = "producer-project-2"
    vpc        = "vpc-producer-2"
    subnet     = "subnet-producer-2"
  }
}

consumers = {
  consumer1 = {
    project_id    = "consumer-project-1"
    vpc           = "vpc-consumer-1"
    subnet        = "subnet-consumer-1"
    producer_name = "producer1"
  },
  consumer2 = {
    project_id    = "consumer-project-2"
    vpc           = "vpc-consumer-2"
    subnet        = "subnet-consumer-2"
    producer_name = "producer2"
  }
}
