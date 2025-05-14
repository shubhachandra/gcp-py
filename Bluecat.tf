resource "google_project_organization_policy" "allow_public_marketplace" {
  project    = "your-project-id"
  constraint = "constraints/commerceorggovernance.disablePublicMarketplace"

  restore_policy {
    default = true
  }
}


resource "google_project_organization_policy" "allow_specific_marketplace_services" {
  project    = "your-project-id"
  constraint = "constraints/commerceorggovernance.marketplaceServices"

  list_policy {
    allow {
      values = [
        "marketplace.gcr.io"
      ]
    }
    suggested_value = "marketplace.gcr.io"
  }
}


provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

# Allow external IPs
resource "google_project_organization_policy" "ext_ip" {
  project    = "your-project-id"
  constraint = "constraints/compute.vmExternalIpAccess"

  restore_policy {
    default = true
  }
}

# Allow public image projects (e.g., BlueCat, Bitnami, etc.)
resource "google_project_organization_policy" "trusted_images" {
  project    = "your-project-id"
  constraint = "constraints/compute.trustedImageProjects"

  list_policy {
    allow {
      values = [
        "projects/bluecatnetworks-public",
        "projects/bitnami-launchpad"
        # Add more image projects as needed
      ]
    }
  }
}

# Allow enabling required services
resource "google_project_organization_policy" "allow_services" {
  project    = "your-project-id"
  constraint = "constraints/serviceuser.services"

  restore_policy {
    default = true
  }
}

# Allow external load balancers
resource "google_project_organization_policy" "load_balancer" {
  project    = "your-project-id"
  constraint = "constraints/compute.restrictLoadBalancerCreationForTypes"

  list_policy {
    allow {
      values = ["EXTERNAL"]
    }
  }
}

# Allow IP forwarding
resource "google_project_organization_policy" "ip_forwarding" {
  project    = "your-project-id"
  constraint = "constraints/compute.vmCanIpForward"

  restore_policy {
    default = true
  }
}

# Allow vendor IAM domains
resource "google_project_organization_policy" "iam_domains" {
  project    = "your-project-id"
  constraint = "constraints/iam.allowedPolicyMemberDomains"

  restore_policy {
    default = true
  }
}

# Allow marketplace procurement (BYOL/Billing-enabled)
resource "google_project_organization_policy" "marketplace" {
  project    = "your-project-id"
  constraint = "constraints/cloudcommerceprocurement.Purchasing"

  restore_policy {
    default = true
  }
}
