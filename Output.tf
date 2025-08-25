terraform {
  required_providers {
    bluecat = {
      source  = "bluecatlabs/bluecat"
      version = ">= 0.1.0"
    }
  }
}

provider "bluecat" {
  username    = var.bluecat_username      # Service account or user name
  password    = var.bluecat_password      # Sensitive, keep in Vault or env vars
  server      = var.bluecat_server        # IP or hostname of BAM/Gateway
  port        = 443                       # Typically 443 (HTTPS) or 80 (HTTP)
  transport   = "https"                   # "https" or "http"
  api_version = "v1"                      # Example: "v1" or the version supported by your Gateway
}
variable "bluecat_username" {
  description = "BlueCat service account username"
}

variable "bluecat_password" {
  description = "BlueCat service account password"
  sensitive   = true
}

variable "bluecat_server" {
  description = "BlueCat BAM or Gateway hostname/IP"
}
export TF_VAR_bluecat_username=svc_terraform
export TF_VAR_bluecat_password='********'
export TF_VAR_bluecat_server='100.120.136.196'
