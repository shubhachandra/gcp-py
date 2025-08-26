Terraform: PSC + Integration Connectors for OAuth

Below are two common, production-friendly patterns. Use Pattern B if your OAuth provider doesn’t natively publish a PSC service attachment (that’s most vendors).

Common prerequisites
# -------------------------
# versions & provider setup
# -------------------------
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.30"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# -------------------------
# network for consumers
# -------------------------
resource "google_compute_network" "consumer_vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "consumer_subnet" {
  name          = "${var.vpc_name}-subnet"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.consumer_vpc.id
}

# A dedicated internal IP for PSC endpoint
resource "google_compute_address" "psc_endpoint_ip" {
  name         = "psc-endpoint-ip"
  region       = var.region
  address_type = "INTERNAL"
  subnetwork   = google_compute_subnetwork.consumer_subnet.id
  purpose      = "PRIVATE_SERVICE_CONNECT"
}

# Service account used by Integration Connectors runtime
resource "google_service_account" "connectors_sa" {
  account_id   = "connectors-runtime"
  display_name = "Integration Connectors Runtime SA"
}

# Allow egress from connectors to PSC IP via firewall
resource "google_compute_firewall" "allow_https_psc" {
  name    = "allow-https-to-psc"
  network = google_compute_network.consumer_vpc.name
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  direction     = "EGRESS"
  destination_ranges = [var.psc_producer_range] # tighten as appropriate
  priority      = 1000
}

variable refernce 
variable "project_id" { type = string }
variable "region"     { type = string  default = "us-central1" }
variable "vpc_name"   { type = string  default = "df-consumer" }
variable "subnet_cidr"{ type = string  default = "10.10.0.0/24" }

# If you know the producer's reachable ranges behind PSC; otherwise keep narrow to your proxy's range.
variable "psc_producer_range" { type = string default = "10.100.0.0/16" }

Pattern A (direct): OAuth provider already publishes a PSC service attachment

Rare but simplest. You’ll be given a service_attachment URI by the provider.

# The consumer-side PSC forwarding rule that points to the provider's service attachment.
resource "google_compute_forwarding_rule" "psc_to_provider" {
  name                  = "psc-to-oauth-provider"
  region                = var.region
  network               = google_compute_network.consumer_vpc.id
  subnetwork            = google_compute_subnetwork.consumer_subnet.id
  ip_address            = google_compute_address.psc_endpoint_ip.id
  load_balancing_scheme = "INTERNAL" # PSC consumer
  target                = var.oauth_provider_service_attachment # e.g. "projects/PROJ/regions/us-central1/serviceAttachments/sa-oauth"
}

variable "oauth_provider_service_attachment" {
  description = "Fully-qualified service attachment URI provided by the OAuth producer."
  type        = string
}

You’ll resolve the PSC endpoint via an Internal DNS A record mapped to the psc_endpoint_ip. Your Integration Connector will call https://oauth.your.internal.domain and traffic flows privately to the provider.

Pattern B (recommended/typical): Publish your own OAuth Proxy via PSC

You host a thin proxy (Cloud Run/Compute Engine/NEG behind a Regional External HTTPS LB or a Regional Internal HTTPS LB depending on your topology), then publish it as a PSC service attachment. Consumers (Integration Connectors) reach it via a private IP.

1) Proxy backend (Cloud Run) that talks to the real OAuth provider

resource "google_service_account" "proxy_sa" {
  account_id   = "oauth-proxy"
  display_name = "OAuth Proxy SA"
}

resource "google_cloud_run_v2_service" "oauth_proxy" {
  name     = "oauth-proxy"
  location = var.region
  template {
    service_account = google_service_account.proxy_sa.email
    containers {
      image = var.proxy_image # Your minimal proxy: exchanges creds + returns {access_token, expires_in}
      env {
        name  = "OAUTH_TOKEN_URL"
        value = var.oauth_token_url # e.g. https://accounts.vendor.com/oauth2/token
      }
      env { name = "CLIENT_ID"     value = var.client_id }
      env { name = "CLIENT_SECRET" value = var.client_secret }
    }
  }
  ingress = "INGRESS_INTERNAL_AND_GCLB"
}
variable "proxy_image"      { type = string }
variable "oauth_token_url"  { type = string }
variable "client_id"        { type = string }
variable "client_secret"    { type = string, sensitive = true }
2) Regional Internal HTTPS LB in front of the proxy

# Serverless NEG for Cloud Run
resource "google_compute_region_network_endpoint_group" "proxy_neg" {
  name                  = "proxy-neg"
  region                = var.region
  network_endpoint_type = "SERVERLESS"
  cloud_run {
    service = google_cloud_run_v2_service.oauth_proxy.name
  }
}

# (Managed) SSL cert – optional if you terminate TLS elsewhere; self-managed certs also work
resource "google_compute_region_ssl_certificate" "proxy_cert" {
  name        = "proxy-cert"
  private_key = var.tls_private_key
  certificate = var.tls_certificate
}

# Backend service
resource "google_compute_region_backend_service" "proxy_backend" {
  name                  = "proxy-backend"
  region                = var.region
  protocol              = "HTTPS"
  load_balancing_scheme = "INTERNAL_MANAGED"
  health_checks         = [google_compute_region_health_check.hc_https.id]
  backend {
    group = google_compute_region_network_endpoint_group.proxy_neg.id
  }
}

resource "google_compute_region_health_check" "hc_https" {
  name   = "proxy-hc-https"
  region = var.region
  https_health_check { port_specification = "USE_SERVING_PORT" }
}

# URL map + target HTTPS proxy
resource "google_compute_region_url_map" "proxy_urlmap" {
  name            = "proxy-urlmap"
  default_service = google_compute_region_backend_service.proxy_backend.id
}

resource "google_compute_region_target_https_proxy" "proxy_target" {
  name            = "proxy-target"
  region          = var.region
  url_map         = google_compute_region_url_map.proxy_urlmap.id
  ssl_certificates = [google_compute_region_ssl_certificate.proxy_cert.id]
}

# Internal HTTPS LB forwarding rule (front door for service attachment)
resource "google_compute_forwarding_rule" "ilb_https" {
  name                  = "ilb-https"
  region                = var.region
  load_balancing_scheme = "INTERNAL_MANAGED"
  ip_protocol           = "TCP"
  port_range            = "443"
  network               = google_compute_network.consumer_vpc.id
  subnetwork            = google_compute_subnetwork.consumer_subnet.id
  target                = google_compute_region_target_https_proxy.proxy_target.id
}

variable "tls_private_key" { type = string, sensitive = true }
variable "tls_certificate" { type = string }
# Allocate a /29 or larger for PSC NAT (producer side)
resource "google_compute_subnetwork" "psc_nat_subnet" {
  name                     = "psc-nat-subnet"
  ip_cidr_range            = "10.11.0.0/29"
  region                   = var.region
  network                  = google_compute_network.consumer_vpc.id
  purpose                  = "PRIVATE_SERVICE_CONNECT"
  role                     = "ACTIVE"
  private_ip_google_access = true
}

resource "google_compute_service_attachment" "oauth_service_attachment" {
  name                = "sa-oauth-proxy"
  region              = var.region
  connection_preference = "ACCEPT_AUTOMATIC"
  nat_subnets         = [google_compute_subnetwork.psc_nat_subnet.id]
  target_service      = google_compute_forwarding_rule.ilb_https.self_link
  enable_proxy_protocol = false
  domain_names        = ["oauth-proxy.private"] # optional (for org scoping/visibility)
}

Output this so the consumer (same project or another) can create the PSC endpoint:


output "service_attachment_uri" {
  value = google_compute_service_attachment.oauth_service_attachment.self_link
}

4) Consumer-side PSC endpoint (in the same VPC as Integration Connectors)

resource "google_compute_forwarding_rule" "psc_consumer" {
  name                  = "psc-consumer-to-oauth-proxy"
  region                = var.region
  network               = google_compute_network.consumer_vpc.id
  subnetwork            = google_compute_subnetwork.consumer_subnet.id
  ip_address            = google_compute_address.psc_endpoint_ip.id
  load_balancing_scheme = "INTERNAL"
  target                = google_compute_service_attachment.oauth_service_attachment.id
}

5) Private DNS for the connector to call (optional but recommended)

resource "google_dns_managed_zone" "internal" {
  name        = "internal-zone"
  dns_name    = "internal.local."
  visibility  = "private"
  description = "Private zone for PSC endpoints"
  private_visibility_config {
    networks { network_url = google_compute_network.consumer_vpc.id }
  }
}

resource "google_dns_record_set" "oauth_proxy_a" {
  name         = "oauth-proxy.internal.local."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.internal.name
  rrdatas      = [google_compute_address.psc_endpoint_ip.address]
}

Now your runtime calls https://oauth-proxy.internal.local and hits the PSC IP.

⸻

Integration Connectors: private connection using PSC

Use Application Integration / Integration Connectors to create a Connection that uses an Endpoint Attachment on your VPC. The connector then resolves the private DNS name and reaches your PSC endpoint.
# Create an endpoint attachment so connectors can egress into your VPC
resource "google_integration_connectors_endpoint_attachment" "ea" {
  endpoint_attachment_id = "ea-oauth"
  location               = var.region
  description            = "Endpoint Attachment for OAuth via PSC"
  service_attachment     = google_compute_service_attachment.oauth_service_attachment.self_link
  project                = var.project_id
}

# Create the Connection that uses that Endpoint Attachment
resource "google_integration_connectors_connection" "oauth_conn" {
  location     = var.region
  connection_id = "oauth-over-psc"
  description   = "Calls OAuth proxy privately via PSC"
  connector_version = "providers/https/versions/1"   # HTTPS generic connector version
  auth_config {
    additional_variables = {
      "AUTH_TYPE"   = "NONE"   # We’re calling our internal proxy with no extra auth; the proxy does OAuth exchange
    }
  }

  destination_configs {
    key = "host"
    destinations {
      host = "oauth-proxy.internal.local"
      port = 443
    }
  }

  # Attach to the endpoint so traffic flows privately
  endpoint_attachment = google_integration_connectors_endpoint_attachment.ea.name

  # Runtime service account
  service_account = google_service_account.connectors_sa.email

  # Optional timeouts, retries, etc.
  node_config {
    min_node_count = 1
    max_node_count = 3
  }
}
In your Integration (built in Application Integration):
	1.	Step “Get Token” → Invoke Connection oauth-over-psc POST /token (or simply / if proxy abstracts it).
	2.	Store $.access_token in a variable.
	3.	Next HTTP call step → add header Authorization: Bearer ${access_token}.

⸻

Security & ops notes (quick)
	•	Keep tokens short-lived (60–3600s). Never persist beyond the flow.
	•	Lock down firewalls to only the connector egress ranges/VPC.
	•	Add request validation on the proxy (allowed audiences/clients).
	•	Log only minimal metadata (no secrets) and rotate CLIENT_SECRET.
	•	Consider Apigee as the proxy if you want quota, spike-arrest, and JWT verification at the edge, then publish Apigee over PSC.

⸻

If you want, I can:
	•	generate a ready-to-apply repo (variables, README, and a tiny Node/Go OAuth-proxy sample), or
	•	tailor this to Dialogflow CX Webhook with a concrete Integration (Application Integration) JSON that maps outputs to the next call.

