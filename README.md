BlueCat’s Terraform provider currently uses API credentials (username/password or API token) to authenticate against BlueCat Gateway/BAM. It does not natively support a “service account” concept like Google Cloud. However, you can achieve a service account–style setup by creating a dedicated BlueCat API user and using it exclusively for automation.

Here’s the approach:

1. Create a Service Account User in BlueCat
	•	Log in to BlueCat Address Manager (BAM) as an admin.
	•	Go to Administration → Users and Groups → Add User.
	•	Create a new user specifically for Terraform automation (e.g., svc_terraform).
	•	Assign only the necessary permissions (least privilege principle).

2. Generate API Credentials
	•	This user will authenticate via BlueCat Gateway REST API.
	•	Obtain the Gateway URL (e.g., https://<gateway-host>/Services/REST/v1).

3. Store Credentials Securely
	•	Never hardcode credentials in Terraform code.
	•	Use environment variables, Terraform Cloud/Enterprise workspace variables, or Vault. Example:

export BLUECAT_USERNAME=svc_terraform
export BLUECAT_PASSWORD='********'
export BLUECAT_SERVER_URL='https://<gateway-host>'



4. Terraform Provider Configuration

Add the BlueCat provider in your Terraform code. For example:

terraform {
  required_providers {
    bluecat = {
      source  = "bluecatlabs/bluecat"
      version = ">=0.1.0"
    }
  }
}

provider "bluecat" {
  username = var.bluecat_username
  password = var.bluecat_password
  server_url = var.bluecat_server_url
}

5. Using Variables Instead of Hardcoding

Define variables in variables.tf:

variable "bluecat_username" {}
variable "bluecat_password" {
  sensitive = true
}
variable "bluecat_server_url" {}

Pass them via environment variables or a tfvars file.

6. Creating a Configuration Object

Example resource to create a configuration:

resource "bluecat_configuration" "example" {
  name        = "Test_Config"
  description = "Created via Terraform"
}

Notes:
	•	If you want OAuth2/JWT-style tokens, BlueCat Gateway 9.6+ supports API tokens, which can mimic service account behavior. You generate a token once and use it in place of username/password. Let me know if you want the API token method documented.
	•	Ensure your BlueCat Gateway instance is accessible to Terraform execution environment.

⸻

Would you like me to give a step-by-step guide for using API tokens (no username/password) so that it works more like a service account? Or detail how to create and manage the dedicated automation user in BlueCat BAM?
