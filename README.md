
⸻

Title:
[BLOCKER] Manually Remove Obsolete IAM Role Bindings for Deleted Groups – Blocking QA Deployments

Description:
Due to a recent group rename and cleanup, older IAM group profiles were deleted. However, IAM roles assigned to these now-nonexistent groups (from previous naming conventions) still persist in GCP IAM policies.

Terraform is unable to detect or remove these bindings because the groups no longer exist. As a result, this is blocking all QA deployments in Core Nonprod and Core Prod SSLC environments, since IAM validation fails due to drift and stale bindings.

⸻

🔥 Impact:
	•	QA deployments are fully blocked
	•	Terraform plan/apply fails due to orphaned IAM bindings
	•	Manual cleanup is urgently required to proceed

⸻

Roles to be Removed (Manually):
	•	roles/vpcaccess.user – Serverless VPC Access
	•	roles/composer.sharedVpcAgent – Composer Shared VPC Agent
	•	roles/container.hostServiceAgentUser – Container Host Service Agent

⸻

Scope:
	•	Projects under Core Nonprod and Core Prod SSLC
	•	Bindings associated with deleted or renamed groups

⸻

Required Actions:
	1.	Identify all IAM role bindings referencing deleted groups.
	2.	Manually delete the obsolete role bindings via console or gcloud.
	3.	Confirm the cleanup and unblock Terraform deployments.
	4.	Notify QA team and infra leads once cleanup is done.

⸻

Priority: Blocker 🚨
Labels: IAM-Cleanup, QA-Blocker, Group-Rename, Terraform-Issue, Manual-Action, Core-Nonprod, Core-Prod, SSLC
Assignee: [Assign appropriately]

Due Date: [Add 1–2 business days from today if urgent]

⸻

Let me know if you’d like a sample gcloud command to list and delete these bindings, or if you want to attach Terraform error logs to the ticket.

---

# 🧩 Private Service Connect (PSC) Terraform Module Usage Guide

## 📌 Overview

This module provisions all necessary Google Cloud components to expose a service through **Private Service Connect (PSC)** using Internal TCP Load Balancing and Network Endpoint Groups. It's designed to enable secure, private access to services across projects/VPCs.

---

## 🗺️ Key Resources Created

### 🔹 `google_compute_subnetwork` - PSC Subnet for NAT

This subnet is reserved for PSC NAT purposes.

```hcl
purpose = "PRIVATE_SERVICE_CONNECT"
private_ip_google_access = true
```

* Dynamically named using region and sanitized CIDR.
* Logging enabled via `log_config`.

---

### 🔹 `google_compute_region_backend_service` - Internal Load Balancer Backend

Acts as the backend service for TCP proxy.

* Uses `INTERNAL MANAGED` load balancing scheme.
* Round-robin locality policy.
* Backend NEG attached with `balancing_mode = CONNECTION`.

---

### 🔹 `google_compute_network_endpoint_group` - PSC NEG

Created for each zone using `NON_GCP_PRIVATE_IP_PORT`.

* Used to point to non-GCP backends (IP\:Port).
* Each zone in `local.zones` gets a NEG instance.

---

### 🔹 `google_compute_region_target_tcp_proxy` - Target TCP Proxy

References the backend service and routes internal traffic to it.

---

### 🔹 `google_compute_address` - Internal IP for Load Balancer

Reserves a static internal IP within the PSC subnet for the forwarding rule.

---

### 🔹 `google_compute_forwarding_rule` - Internal Forwarding Rule

Establishes internal routing using the TCP proxy.

* Includes PSC subnet and internal IP.
* Can optionally enable global access.

---

### 🔹 Output: `psc_service_attachment`

Outputs the final **PSC Service Attachment** that can be shared with consumers.

---

## ⚙️ Required Input Variables

| Variable                | Description                                  | Default       |
| ----------------------- | -------------------------------------------- | ------------- |
| `psc_nat_subnets`       | List of subnet CIDRs to allocate for PSC NAT | —             |
| `project_id`            | Target project for all resources             | —             |
| `region`                | Deployment region                            | `us-central1` |
| `port_range`            | Port range to expose over forwarding rule    | —             |
| `ip_protocol`           | TCP/UDP                                      | `TCP`         |
| `global_access`         | Allow global access to forwarding rule       | `true`        |
| `max_connections`       | Max connections per NEG                      | `500`         |
| `tenant`, `environment` | Used to fetch shared networking info         | —             |
| `zones`                 | List of zones for NEG deployment             | —             |

---

## 💡 Logging Configuration (Optional)

If `enable_log = true`, backend service flow logs will be configured:

```hcl
log_config {
  aggregation_interval = "INTERVAL_5_SEC"
  flow_sampling        = 0.5
  metadata             = "INCLUDE_ALL_METADATA"
  filter_expr          = "true"
}
```

---

## 🩺 Health Check Configuration

* `healthy_threshold`: Marks unhealthy endpoints as healthy after `n` successful probes.
* `unhealthy_threshold`: Marks healthy endpoints as unhealthy after `n` failures.
* `health_check_interval`: Interval in seconds between probes.
* `health_check_timeout`: Response wait time per probe.

---

## 🧪 Example Usage

```hcl
module "psc_service" {
  source              = "./modules/psc"
  project_id          = "my-project"
  region              = "us-central1"
  psc_nat_subnets     = ["10.10.1.0/24"]
  port_range          = "443"
  ip_protocol         = "TCP"
  global_access       = true
  max_connections     = 1000
  ...
}
```

---

## 📤 Output

```hcl
output "psc_service_attachment" {
  value = google_compute_service_attachment.psc_ilb_service_attachment.id
}
```

This value can be shared with service consumers to connect to the service privately.

---

## 🛡️ Validation Rules

* Tenant must be one of `AD-ENT` or `QA-ENT`.
* App ID and AU must follow regex formats.
* Health check thresholds must be between `1-10`.

---

## 📚 References

* [PSC Interface Codelab](https://codelabs.developers.google.com/codelabs/psc-interface)
* [Terraform Google Provider Docs](https://registry.terraform.io/providers/hashicorp/google/latest/docs)

---

Would you like me to help you **convert this to markdown**, **attach diagrams**, or create a **landing page** inside Confluence?
