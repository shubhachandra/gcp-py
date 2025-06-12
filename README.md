As discussed, we need to make space to add 4 new group members. This may involve identifying and deleting a few existing projects.

I’ve already shared the background with Prakash. Requesting your support in reviewing the current usage and helping proceed accordingly. Please also keep in mind the earlier concerns shared regarding group roles and capacity.

Thanks for your support!


⸻

Revised Message:

Since adding or removing projects is outside the scope of the networking team, we already have the required groups for all necessary roles. The only clarification needed is around the need for a new hostvpc role—why can’t we use the existing subnet-sa group?

I’ll connect with Richard to understand the rationale.

Additionally, we should involve the Ops team to identify and delete the appropriate projects. They should take ownership of this task, as the App team doesn’t typically interact with the Networking or LZ teams.

Decisions around project deletions fall under the Ops team’s responsibility—not Networking or LZ—so we cannot approach the App team directly for this. If we try to do so, Ops may push the request back to us.

Let’s clearly communicate what we need: space for four new group members, and request the Ops team’s support in enabling that.

⸻

Let me know if you want it adapted to an email format or Slack message style.

---

## ✅ JIRA Ticket

**Title**:
Create PSC Terraform Submodules for Backend, Endpoints, and Custom Service Attachment

**Type**: Story
**Priority**: High
**Assignee**: *\[Assign to yourself or infra team]*
**Component**: GCP Terraform Modules
**Labels**: `PSC`, `terraform`, `modules`, `infra`
**Epic Link**: Private Service Connect Platform

---

### Description:

The `psc-publish-onprem-service` module is finalized and functional. To modularize PSC architecture and support varied publishing patterns, we need to split out reusable submodules based on this foundation. The following three Terraform submodules will be created:

1. **psc-generic-backend**
2. **psc-generic-endpoints**
3. **psc-publish-custom-service**

Each of these will handle a distinct part of the PSC setup and can be reused individually or composed as needed.

---

### Tasks:

* [x] Review and finalize `psc-publish-onprem-service` as reference
* [ ] Create `psc-generic-backend` with backend service, NEG, health checks, proxy
* [ ] Create `psc-generic-endpoints` with internal IP + forwarding rule
* [ ] Create `psc-publish-custom-service` with `google_compute_service_attachment`
* [ ] Write a Confluence documentation page with explanation and usage examples
* [ ] Peer review and integrate with existing PSC Factory modules

---

### Acceptance Criteria:

* All three modules are independently deployable and reusable
* Variable inputs and outputs are documented clearly
* Module dependencies are decoupled and composable
* Confluence page includes explanation, diagrams, and code examples
* Modules tested in sandbox environment with sample deployment

---

## 🧾 Confluence Page (Draft)

**Title**: Google Cloud PSC Terraform Submodules

**Parent Page**: Infrastructure → GCP Platform Modules → Private Service Connect

---

### Overview

To modularize and scale our Private Service Connect (PSC) setup on GCP, we've created 4 Terraform submodules. These support use cases for publishing on-prem, internal, or partner services using Google's PSC infrastructure.

---

### 📦 Submodules

#### 1. ✅ `psc-publish-onprem-service` (Reference Module)

**Purpose**: Full stack PSC publishing module for on-prem services
**Includes**:

* PSC NAT subnet
* NEG and Health Checks
* Backend Service and Target TCP Proxy
* ILB Forwarding Rule
* Service Attachment

**Usage**: End-to-end ready PSC setup for publishing private IP endpoints hosted on-prem.

---

#### 2. 🛠️ `psc-generic-backend` *(To Be Developed)*

**Purpose**: Provision backend infrastructure required for PSC publishing

**Includes**:

* `google_compute_region_network_endpoint_group` (NON\_GCP\_PRIVATE\_IP\_PORT)
* `google_compute_region_backend_service`
* `google_compute_region_health_check`
* `google_compute_region_target_tcp_proxy`

**Input**:

* `endpoints` (map of IPs + ports)
* `health_check` settings
* `project_id`, `region`, `tenant`, `environment`

**Output**:

* NEG and backend service name

**Use Case**: Used when backend service and traffic routing infra are needed but not IP or service attachment.

---

#### 3. 🛠️ `psc-generic-endpoints` *(To Be Developed)*

**Purpose**: Create an internal IP and forwarding rule for exposing a backend via PSC

**Includes**:

* `google_compute_address`
* `google_compute_forwarding_rule`

**Input**:

* `target`: backend service or proxy
* `port_range`, `ip_protocol`
* `network_self_link`, `subnetwork`

**Output**:

* Internal IP
* Forwarding rule name

**Use Case**: Used to bind existing backend to an internal PSC-ready IP.

---

#### 4. 🛠️ `psc-publish-custom-service` *(To Be Developed)*

**Purpose**: Attach an existing forwarding rule or target service via PSC

**Includes**:

* `google_compute_service_attachment`

**Input**:

* `target_service`
* `psc_nat_subnets`
* `connection_preference`, `consumer_accept_lists`

**Output**:

* Service attachment URL

**Use Case**: Use when backend infra already exists and you only need to expose it via PSC.

---

### 📘 Diagrams

> (Add architecture diagrams here showing module separation. E.g. `psc-generic-backend → psc-generic-endpoints → psc-publish-custom-service`)

---

### 📂 Repository Layout

```
terraform/
│
├── modules/
│   ├── psc-publish-onprem-service/
│   ├── psc-generic-backend/          # In progress
│   ├── psc-generic-endpoints/        # In progress
│   └── psc-publish-custom-service/   # In progress
```

---

### ✅ Next Steps

* Implement and validate each submodule in `lab` environment
* Update this page with outputs and versioning
* Add module examples to `wf-private-service-connect-factory`

---

Would you like me to generate the **`README.md` files** for each module next, including input/output tables and usage examples?
