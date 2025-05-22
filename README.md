Here’s an updated **Jira ticket** description with your new requirement and a revised **email to Daniel**. This includes the Terraform validation for the new `psidco` (disco) environment variable in the **project-factory** repository.

---

### ✅ **Updated Jira Ticket: Add New CI Environment Variable `psidco`**

**Title:**
Introduce new CI environment variable `psidco` (Product Discovery) and update Terraform validations

**Type:**
Task / Change Request

**Priority:**
High

**Description:**
We are introducing a new CI environment variable called `psidco` (short for **Product Discovery**), in addition to the existing environment variables: `prod`, `nonprod`, `sandbox`, and `core`.

**Product Discovery (psidco)** is a new SDLC phase aimed at **validating ideas, prototyping, collecting stakeholder feedback, and checking feasibility before full-scale development begins**. It helps teams de-risk projects and align early on.

### Scope of Work:

1. **CI/CD Updates**

   * Add `psidco` as a valid CI environment variable in all relevant pipelines.
   * Update logic handling CI environment selection to account for `psidco`.

2. **Terraform Validation Updates**

   * Modify the **project-factory** repo to recognize `psidco` as a valid environment in Terraform validation rules.
   * Ensure `validate_environment` includes `psidco` as a permitted value.

3. **Documentation**

   * Update developer documentation and CI environment references to include `psidco`.

**Acceptance Criteria:**

* CI/CD scripts accept `psidco` as a valid environment.
* Terraform `validate_environment` logic in project-factory repo includes `psidco`.
* All validation and testing steps completed successfully in staging/test.
* Documentation updated.

---

### 📧 **Revised Email to Daniel**

**Subject:** Urgent: Add `psidco` Environment to CI/CD and Terraform Validation (Landing Zone Board)

Hi Daniel,

I’ve created a high-priority Jira ticket to introduce a new CI environment variable: **`psidco`**, representing the **Product Discovery** phase.

This phase supports early-stage validation, prototyping, and feasibility analysis before full development. Along with updating our pipelines, this also requires a **Terraform validation change in the `project-factory` repo** to accept `psidco` as a valid environment (`validate_environment` logic).

Can you please accept and route this ticket to the **Landing Zone** board for immediate action?

Let me know if you need further details.

Best regards,
**Shubhachandra S Hotpeti**

---

Let me know if you want help writing the actual Terraform code snippet for `validate_environment`, or if this needs to be formatted for Jira or GitHub Issues.
