Thanks! Since the Jira is for **creating a GCP project** for the new SDLC environment called **"Prod Discovery"**, here's an updated Jira description:

---

### **Title:**

Create GCP Project for New SDLC Environment – *Prod Discovery*

---

### **Description:**

As a **Network Engineer**, I need to create a new **GCP project** to support the **"Prod Discovery"** SDLC environment. This project will serve as the foundation for provisioning infrastructure components such as VPC, subnets, compute, and other cloud services required by the development and production teams.

---

### **Scope of Work:**

* Create a new GCP project under the appropriate **folder or organization node**.
* Name the project following naming conventions (e.g., `proj-prod-discovery`).
* Set the correct **billing account** and **organization/folder ID**.
* Apply required **labels/tags** (e.g., `env = prod`, `sdlc = discovery`, `owner = networking`).
* Enable core **APIs** such as:

  * Compute Engine API
  * VPC Access API
  * Cloud Resource Manager API
* Assign necessary **IAM roles** to networking and project owners.
* Ensure **project is ready for network provisioning** (VPC, subnets, etc.).

---

### **Acceptance Criteria:**

* A new GCP project named `prod-discovery` (or per naming standard) is created.
* Billing account is correctly linked.
* Required APIs are enabled successfully.
* Labels and IAM roles are applied.
* Project is available for use in Terraform/IaC deployments.

---

Let me know if you're using **Terraform**, **gcloud CLI**, or manual creation, and I can provide a tailored task breakdown or code.
