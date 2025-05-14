Understood. Here's a refined, **professional version** of the PoC document for **Confluence**, with no mention of HSBC and a clean layout. This version includes **actionable checkpoints** and excludes any direct references to specific organizations or banks.

---

# **Proof of Concept – BlueCat IPAM Implementation on GCP Sandbox**

---

## **1. Purpose**

This PoC is intended to evaluate the feasibility of deploying and utilizing **BlueCat IP Address Management (IPAM)** on the **GCP QA-ent sandbox environment**. The goal is to modernize IP address management across multiple SDLC stages by eliminating manual spreadsheets, reducing conflicts, and streamlining change request workflows.

---

## **2. Current Landscape & Challenges**

### **Environment Overview**

| Environment | SDLC Stages                                    | Approximate Subnet Count |
| ----------- | ---------------------------------------------- | ------------------------ |
| QA-ent      | prod, nonprod, sandbox, pdisco, PAA, PCI, core | 100+ subnets per SDLC    |
| AD-ent      | prod, nonprod, sandbox, pdisco, PAA, PCI, core | 100+ subnets per SDLC    |

### **Key Challenges**

* Manual Excel-based tracking leads to **IP conflicts**
* Delayed **Change Request (CR)** approvals and provisioning
* Lack of real-time visibility and **audit trails**
* Increasing operational complexity and risk

---

## **3. Why BlueCat?**

| Capability                   | Benefit                                                     |
| ---------------------------- | ----------------------------------------------------------- |
| Centralized IP Management    | Unified platform across all SDLC stages and environments    |
| Real-Time Conflict Detection | Prevent overlapping allocations at the source               |
| Role-Based Access Control    | Granular access and governance across teams                 |
| API & Automation Ready       | Enables integration with CI/CD and infrastructure workflows |
| Full Auditability            | Tracks changes, ownership, and usage history                |

---

## **4. PoC Scope**

| Item                   | Details                             |
| ---------------------- | ----------------------------------- |
| **Environment**        | QA-ent (sandbox)                    |
| **Deployment**         | GCP Marketplace VM                  |
| **Instance Type**      | e2-medium (1 shared vCPU, 4 GB RAM) |
| **Disk**               | 0 GB (initial setup)                |
| **License Type**       | BYOL (license to be provided)       |
| **PoC Duration**       | 2 Sprints (\~4 weeks)               |
| **Data Centers**       | 14                                  |
| **Managed Interfaces** | 14                                  |
| **Global Tags**        | 14                                  |

---

## **5. Estimated Cost**

| Component                  | Estimate                           |
| -------------------------- | ---------------------------------- |
| VM Instance (e2-medium)    | USD 24.46/month                    |
| Persistent Disk            | USD 0.00/month                     |
| Sustained Use Discount     | USD 0.00/month                     |
| **Total (Infrastructure)** | **USD 24.46/month** + BYOL license |

> 🔔 *License key to be provided by internal stakeholder. Infrastructure cost will require approval.*

---

## **6. Required APIs in GCP**

To deploy from the GCP Marketplace:

* `Compute Engine API`
* `Infrastructure Manager API`

---

## **7. Support Required**

### **Networking / Landing Zone Team**

* Confirm **VM provisioning process** for sandbox project
* Clarify if **intake or ticketing** is needed
* Provide assistance with **firewall rules**, **routing**, or **NAT configuration**

### **Leadership / Governance**

* Approve **infrastructure costs**
* Endorse PoC execution in current scope

---

## **8. PoC Objectives & Checkpoints**

| Checkpoint                                      | Status    | Owner         |
| ----------------------------------------------- | --------- | ------------- |
| Enable required APIs                            | ⬜ Pending | Platform Team |
| Deploy BlueCat VM in QA-ent sandbox             | ⬜ Pending | Platform Team |
| Import subnet data for one SDLC (e.g., nonprod) | ⬜ Pending | Network Team  |
| Simulate IP reservation + CR workflow           | ⬜ Pending | Platform Team |
| Validate conflict detection logic               | ⬜ Pending | All           |
| Capture audit trail and reporting capability    | ⬜ Pending | All           |
| Compile PoC summary and recommendations         | ⬜ Pending | Project Lead  |

---

## **9. Expected Outcomes**

* Confirmation of BlueCat's deployment and operational fit for GCP
* Demonstrated improvement in IP allocation efficiency
* Reduced risks of IP conflicts across SDLCs
* Clear documentation to support decision on broader adoption

---

Let me know if you'd like:

* A **Confluence status table macro** version
* A **decision log template** for leadership sign-off
* A **Jira integration view** for sprint tracking and task assignment
