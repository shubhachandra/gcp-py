resource "google_cloud_identity_group_membership" "sa_membership" {
  group = var.group_id

  preferred_member_key {
    id = var.service_account_email
  }

  roles {
    name = "MEMBER"
  }
}


variable "service_account_email" {
  description = "Service account email to add to the group"
  type        = string
}

variable "group_id" {
  description = "Group ID in format 'groups/{group_id}' (not group email)"
  type        = string
}

output "membership_resource_name" {
  value       = google_cloud_identity_group_membership.sa_membership.name
  description = "Full resource name of the membership"
}
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.58.0"
    }
  }
  required_version = ">= 1.3"
}
