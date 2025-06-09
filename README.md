Thanks! Here's the **revised Jira ticket** description incorporating that the changes apply to the **Project Factory code**:

---

### **Title / Summary:**

Refactor Project Factory IAM Code to Use Modules and Add Service Agents via Group Bindings

---

### **Type:**

Story / Task

---

### **Category / Component:**

Terraform – Project Factory / IAM / Service Agent Bindings

---

### **Description:**

This task involves making structured improvements to the **Project Factory Terraform code** to address IAM policy binding limits and improve scalability using modules and group-based service account bindings.

---

### **Phased Approach:**

#### ✅ **Phase 1: Test Existing Project Factory IAM Code**

* Validate the current IAM binding logic within the Project Factory.
* Ensure the baseline implementation is functioning correctly before introducing changes.

#### ✅ **Phase 2: Introduce and Test Modules**

* Refactor IAM-related logic in the Project Factory to use **reusable Terraform modules**.
* Perform unit and integration testing to confirm the correctness of module behavior.

#### ✅ **Phase 3: Add Service Agents via Group Bindings**

Transition from directly assigning roles to service accounts to assigning roles to **groups that include service accounts**.

* Implement changes incrementally by role:

  * Start with the **Network User** role.
  * Add **VPC Access User**, **GKE Shared VPC Agent**, and finally **Composer VPC Agent**.

---

### **Acceptance Criteria:**

* [ ] Existing IAM logic in Project Factory validated.
* [ ] Refactored code uses modular structure.
* [ ] Service accounts added to appropriate groups.
* [ ] Group-based bindings implemented for:

  * Network User
  * VPC Access User
  * GKE Shared VPC Agent
  * Composer VPC Agent
* [ ] Terraform plans and applies complete without hitting binding quota limits.

---

Let me know if you want subtasks created for each phase or mapped to a parent Epic.
