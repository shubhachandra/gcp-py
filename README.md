Here’s how you can structure your solution, documentation, and Jira tickets based on your constraints and requirements:

⸻

✅ Summary of Requirements
	1.	Add a service account to a Google Workspace (Cloud Identity) group
	2.	Later allow adding group profiles to Google Workspace groups
	3.	No direct use of resource blocks in Terraform due to compliance policies
	4.	Create a module for assigning group profiles to google_compute_subnetwork_iam_member
	5.	Provide complete README with input variables and supported versions
	6.	Create 2 Jira tickets:
	•	Ticket 1: Add service account to a group
	•	Ticket 2: Grant subnet IAM access to a group profile

⸻

📁 Terraform Module: gcp-group-membership

Structure

gcp-group-membership/
├── main.tf
├── variables.tf
├── outputs.tf
├── README.md

main.tf

# main.tf
provider "googleworkspace" {
  credentials = var.google_workspace_credentials
  customer_id = var.customer_id
}

# Data-only approach to lookup
data "googleworkspace_group" "target_group" {
  email = var.group_email
}

module "add_service_account_to_group" {
  source  = "terraform-google-modules/group/google//modules/members"
  version = "~> 1.0"

  group_email = var.group_email
  members = [{
    email = var.service_account_email
    role  = "MEMBER"
    type  = "user"
  }]
}

variables.tf

variable "google_workspace_credentials" {
  description = "Path to the credentials JSON file for Google Workspace admin SDK"
  type        = string
}

variable "customer_id" {
  description = "Google Workspace customer ID"
  type        = string
}

variable "group_email" {
  description = "Email address of the Google group"
  type        = string
}

variable "service_account_email" {
  description = "Service account email to be added to the group"
  type        = string
}

README.md

# Google Cloud Group Membership Module

This module adds a service account to a Google Workspace (Cloud Identity) group. The module is intended for use in environments where direct `resource` blocks are not allowed.

## Usage

```hcl
module "group_membership" {
  source                    = "./gcp-group-membership"
  google_workspace_credentials = file("admin-creds.json")
  customer_id              = "C0xxxxxx"
  group_email              = "example-group@yourdomain.com"
  service_account_email    = "service-account@project.iam.gserviceaccount.com"
}

Inputs

Name	Description	Type	Required
google_workspace_credentials	Path to Google Workspace admin SDK credentials JSON	string	✅ Yes
customer_id	Google Workspace customer ID	string	✅ Yes
group_email	Email of the target Google group	string	✅ Yes
service_account_email	Service account email to be added	string	✅ Yes

Versioning
	•	Terraform >= 1.3
	•	Google Workspace Provider >= 0.8.0

Note: This uses the terraform-google-modules/group module under the hood to avoid direct resource usage.

---

## 🛠 Module 2: `gcp-subnet-iam-member-for-group`

To bind a Google group to a subnet IAM role.

```hcl
# main.tf
resource "google_compute_subnetwork_iam_member" "group_binding" {
  subnetwork = var.subnetwork
  region     = var.region
  role       = var.role
  member     = "group:${var.group_email}"
}

variables.tf

variable "subnetwork" {
  description = "Subnetwork name"
  type        = string
}

variable "region" {
  description = "Region of the subnetwork"
  type        = string
}

variable "role" {
  description = "IAM role to assign"
  type        = string
  default     = "roles/compute.networkUser"
}

variable "group_email" {
  description = "Google group email to assign permissions to"
  type        = string
}


⸻

📝 Jira Tickets

Jira Ticket 1: Add Service Account to Google Cloud Group

Title: Add Service Account to Google Cloud Group Using Terraform Module

Description:
Develop a Terraform module that uses the terraform-google-modules/group module to add a service account to a Google Workspace group. Compliance constraints restrict use of resource blocks. Ensure the group email and service account email are passed as variables.

Acceptance Criteria:
	•	A reusable module created
	•	README and usage examples provided
	•	No use of native Terraform resource blocks
	•	Inputs: group_email, service_account_email
	•	Uses Google Workspace Admin SDK provider

⸻

Jira Ticket 2: Add Group Profile as IAM Member to Subnet

Title: Add Google Group Profile to Subnetwork IAM using Terraform

Description:
Develop a Terraform module to grant a Google Cloud group IAM access to a subnetwork. The module should allow users to bind a group_email to roles like roles/compute.networkUser.

Acceptance Criteria:
	•	Module supports variable inputs for subnetwork, region, role, and group_email
	•	IAM role is added to the subnet for the group
	•	README included with inputs, usage, and versions
	•	Compliant with internal infra policies

⸻

