Perfect 👍 let’s build you a ready-to-use starter Terraform repo layout with two modules:
	•	primary_blocks → creates all the reserved routable blocks for every tenant × SDLC × region
	•	request_range → allows requesting new subnets (explicit CIDR or next-available) inside one of the primary blocks

I’ll scaffold the folders, variables, and show example usage.

⸻

📂 Folder layout

bluecat-terraform/
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── modules/
    ├── primary_blocks/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── request_range/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf


⸻

🔹 Root files

providers.tf

terraform {
  required_providers {
    bluecat = {
      source  = "bluecatlabs/bluecat"
      version = ">= 2.0.0"
    }
  }
  required_version = ">= 1.4"
}

provider "bluecat" {
  server           = var.bluecat_server
  port             = var.bluecat_port
  transport        = "https"
  api_version      = "1"
  username         = var.bluecat_username
  password         = var.bluecat_password
  encrypt_password = false
}

variables.tf

variable "bluecat_server" {}
variable "bluecat_port" { default = 443 }
variable "bluecat_username" {}
variable "bluecat_password" { sensitive = true }

variable "tenants" {
  type    = list(string)
  default = ["ad-ent", "qa-ent"]
}

variable "sdlcs" {
  type    = list(string)
  default = ["prod", "core", "nonprod", "sandbox", "pdisco", "paa", "pci"]
}

variable "regions" {
  type    = list(string)
  default = ["us-central1", "us-east1", "us-east4", "us-south1"]
}

# Example primary routable ranges (seeded with sandbox example)
# You can extend for each tenant|sdlc|region combo.
variable "primary_ranges" {
  type = map(string)
  default = {
    "ad-ent|sandbox|us-east1" = "100.120.0.0/16"
    "qa-ent|sandbox|us-east1" = "100.121.0.0/16"
  }
}

main.tf

# Create tenant configurations
resource "bluecat_configuration" "tenants" {
  for_each   = toset(var.tenants)
  name       = each.key
  properties = "description=Terraform-managed config for ${each.key}"
}

# Create all primary routable blocks
module "primary_blocks" {
  source          = "./modules/primary_blocks"
  primary_ranges  = var.primary_ranges
}

# Example request for a pupi range
module "request_range_example" {
  source            = "./modules/request_range"
  tenant            = "ad-ent"
  sdlc              = "sandbox"
  region            = "us-east1"
  range_type        = "pupi"
  parent_block_cidr = "100.120.0.0/16"
  desired_size      = 20   # /20
}


⸻

🔹 Module: primary_blocks

main.tf

resource "bluecat_ipv4block" "primary" {
  for_each      = var.primary_ranges
  configuration = split("|", each.key)[0]   # tenant name
  name          = replace(each.key, "|", "_")
  address       = cidrhost(each.value, 0)
  cidr          = each.value
  properties    = "tenant=${split(\"|\", each.key)[0]},sdlc=${split(\"|\", each.key)[1]},region=${split(\"|\", each.key)[2]},range_type=routable"
}

variables.tf

variable "primary_ranges" {
  type        = map(string)
  description = "Map of tenant|sdlc|region => CIDR block"
}

outputs.tf

output "primary_blocks" {
  value = bluecat_ipv4block.primary
}


⸻

🔹 Module: request_range

main.tf

# If desired_cidr provided, create explicit network
resource "bluecat_ipv4network" "explicit" {
  count         = var.desired_cidr != null ? 1 : 0
  configuration = var.tenant
  name          = "${var.tenant}_${var.sdlc}_${var.region}_${var.range_type}_${replace(var.desired_cidr, "/", "_")}"
  cidr          = var.desired_cidr
  properties    = "tenant=${var.tenant},sdlc=${var.sdlc},region=${var.region},range_type=${var.range_type},gcp_subnet=${var.gcp_subnet}"
}

# Else request next-available from parent block
resource "bluecat_ipv4network" "next_available" {
  count         = var.desired_cidr == null ? 1 : 0
  configuration = var.tenant
  name          = "${var.tenant}_${var.sdlc}_${var.region}_${var.range_type}_next"
  parent_block  = var.parent_block_cidr
  size          = pow(2, 32 - var.desired_size)
  allocated_id  = timestamp()
  properties    = "tenant=${var.tenant},sdlc=${var.sdlc},region=${var.region},range_type=${var.range_type},gcp_subnet=${var.gcp_subnet}"
}

variables.tf

variable "tenant" {}
variable "sdlc" {}
variable "region" {}
variable "range_type" { description = "routable | pupi | nonroutable" }

variable "desired_cidr" {
  type    = string
  default = null
}

variable "parent_block_cidr" {
  type    = string
  default = null
}

variable "desired_size" {
  type    = number
  default = null
}

variable "gcp_subnet" {
  type    = string
  default = ""
}

outputs.tf

output "requested_network" {
  value = {
    explicit       = one(bluecat_ipv4network.explicit[*].cidr)
    next_available = one(bluecat_ipv4network.next_available[*].cidr)
  }
}


⸻

✅ How it works
	•	primary_blocks seeds all tenant/SDLC/region routable ranges.
	•	request_range lets you ask for a new subnet:
	•	If you supply desired_cidr, it creates exactly that.
	•	If not, it asks BlueCat for the next-available subnet inside parent_block_cidr.

Labels (properties) store: tenant, sdlc, region, range_type, GCP subnet reference.

⸻

👉 Do you want me to pre-populate the primary_ranges map for all tenants × 7 SDLC × 4 regions (56 entries) with placeholder CIDRs (like 10.x.y.0/16), so you can directly adjust them?
