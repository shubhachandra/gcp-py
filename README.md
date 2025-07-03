Sure — here’s a **crisp and clear** Jira ticket draft you can copy-paste and adapt:

---

**Title:** Provision folder and service projects for Palo Alto deployment in GCP

**Description:**
As part of implementing Palo Alto VM firewalls in GCP, we need to provision a new folder and create two service projects under this folder. These service projects will act as service projects connected to the core host project through Shared VPC.

**Acceptance Criteria:**

* Create a dedicated folder in the specified GCP parent folder for Palo Alto resources
* Provision two service projects within this folder

  * Project 1: `<insert project name>`
  * Project 2: `<insert project name>`
* Attach these service projects to the core host project’s Shared VPC
* Add multiple core subnets from the host project as Shared VPC subnets to these service projects
* Confirm permissions and IAM bindings are in place for the Palo Alto deployment

**Additional Notes:**

* The provisioning will be done using the project provisioning repo
* Ensure naming conventions and organization policies are followed
* Validate connectivity between the service projects and the Shared VPC

**Priority:** High

---

If you’d like, I can help you expand it with more technical details (like subnet names, IAM roles, folder IDs, etc.) — just let me know!
