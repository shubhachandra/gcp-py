Got it 👍 You want a Terraform module that:
	1.	Requests a new subnet (CIDR) from BlueCat IPAM.
	2.	Captures that subnet in an output variable.
	3.	Uses that subnet to create a GCP subnet (or another cloud subnet) with a name convention like:

sandbox-netb-fwd-0212364-1x1-usc1-100-120-24-0-24

Where:
	•	sandbox → environment
	•	netb → network code/prefix
	•	fwd → usage/type (forwarding, workload, etc.)
	•	0212364 → request ID / ticket / unique identifier
	•	1x1 → size/shape code (could be tied to CIDR size)
	•	usc1 → region
	•	100-120-24-0-24 → sanitized CIDR (replace . with -)

⸻

Step 1: BlueCat Terraform Provider

BlueCat provides a Terraform provider (bluecatlabs/bluecat).
Example to request a new subnet:

terraform {
  required_providers {
    bluecat = {
      source  = "bluecatlabs/bluecat"
      version = "~> 1.0"
    }
  }
}

provider "bluecat" {
  url      = var.bluecat_url
  username = var.bluecat_username
  password = var.bluecat_password
}


⸻

Step 2: Request a new subnet from BlueCat

resource "bluecat_ip4_block" "new_subnet" {
  parent_block = var.parent_block     # e.g. "100.120.0.0/16"
  cidr         = var.subnet_size      # e.g. 24
  name         = "requested-subnet"
  properties   = "state=ALLOCATED"
}

This will allocate a new /24 from BlueCat under the given parent block.

⸻

Step 3: Capture the allocated CIDR in an output

output "allocated_subnet" {
  value = bluecat_ip4_block.new_subnet.cidr
}

Example output → 100.120.24.0/24

⸻

Step 4: Generate GCP subnet name dynamically

Terraform format() + replace() can build the subnet name:

locals {
  sanitized_cidr = replace(bluecat_ip4_block.new_subnet.cidr, ".", "-")
  subnet_name    = format(
    "%s-%s-%s-%s-%s-%s",
    var.env,                # sandbox
    var.network_code,       # netb
    var.type,               # fwd
    var.request_id,         # 0212364
    var.size_code,          # 1x1
    var.region,             # usc1
  )

  full_subnet_name = "${local.subnet_name}-${local.sanitized_cidr}"
}

This produces:

sandbox-netb-fwd-0212364-1x1-usc1-100-120-24-0-24

⸻

Step 5: Create subnet in GCP

resource "google_compute_subnetwork" "requested" {
  name          = local.full_subnet_name
  ip_cidr_range = bluecat_ip4_block.new_subnet.cidr
  region        = var.region
  network       = var.vpc_self_link
}


⸻

✅ Final Outputs

output "subnet_name" {
  value = google_compute_subnetwork.requested.name
}

output "subnet_cidr" {
  value = google_compute_subnetwork.requested.ip_cidr_range
}


⸻

👉 Shubh, before I polish this into a reusable module structure (variables.tf, outputs.tf, main.tf), do you want:
	1.	The BlueCat allocation + GCP subnet creation together in one module
(end-to-end automation),

or
	2.	Separate modules: one for BlueCat allocation, another for GCP subnet creation, linked via outputs?
 
