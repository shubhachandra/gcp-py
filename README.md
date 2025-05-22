Here’s a Jira ticket description along with an email draft to Daniel for your request.

---

### ✅ **Jira Ticket: Add New CI Environment Variable `psidco`**

**Title:**
Introduce new CI environment variable `psidco` for Product Discovery phase

**Type:**
Task / Change Request

**Priority:**
High

**Description:**
We need to introduce a new CI environment variable called `psidco`, in addition to the existing environment variables `prod`, `nonprod`, `sandbox`, and `core`.

`psidco` stands for **Product Discovery**, a newly introduced SDLC stage aimed at early-stage validation of ideas, prototyping, stakeholder feedback collection, and feasibility assessments **before full-scale development begins**.

This will allow the CI/CD pipeline to identify and handle deployments or integrations specific to the discovery phase with proper isolation from other environments.

Please treat this as a **high-priority** item and include it in the next sprint for implementation and testing.

**Acceptance Criteria:**

* A new CI environment variable `psidco` is defined and handled consistently across pipelines.
* CI/CD scripts and any conditional logic using environment names are updated to recognize `psidco`.
* Documentation is updated to reflect the new environment.
* Validated in a test repo before going live.

---

### 📧 **Email to Daniel**

**Subject:** Request to Accept High-Priority Ticket for New CI Environment Variable `psidco`

Hi Daniel,

Hope you’re doing well.

I’ve created a high-priority Jira ticket to introduce a new CI environment variable `psidco` for the **Product Discovery** phase, which will join the existing set of environments (`prod`, `nonprod`, `sandbox`, and `core`). The Product Discovery phase focuses on rapid prototyping, stakeholder alignment, and feasibility validation before full development.

Could you please help in accepting this ticket to the **Landing Zone** board and prioritize it for the upcoming sprint?

Let me know if you need any additional details.

Best regards,
**Shubhachandra S Hotpeti**

---

Let me know if you'd like this added in your Jira system or sent via Outlook/Gmail, or if you’d like to attach any documentation.
