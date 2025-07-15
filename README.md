Here’s a clearer and more professional version of your message:

---

**Hi Hema,**

Just a small correction: when we raise an intake request, we actually create a Jira ticket in the **Ops board**—it’s not a **CR**. The Ops team reviews the ticket and requests us to fill in all the required details as per their format/template. Once evaluated, they provide a **CR number** and a **scheduled date** for the change.

The CR window typically remains open for 1 hour, during which they handle the approval, merge, and apply processes.

So, we should phrase it as: "**An automated intake request has been created, and corresponding Jira tickets exist on the Ops board.**" We need to follow up with them for the CR number, CR date, and ensure all fields in the intake request are filled accurately.

---

Let me know if you'd like this shortened or tailored for email.

Here is a **Jira Change Description Template** that cleanly addresses each of the questions you listed. You can copy-paste this into your Jira issue under the **Description** field.

---

### 🔧 **Change Description Template – Subnet Reclamation**

---

**1. Description:**
Reclaiming unused subnets (no attached resources for 90+ days) across sandbox, nonprod, and production GCP projects. This includes delinking subnets from service projects and removing them from Terraform state. Subnet details (name, IP range, SDLC, app ID) have been validated with app teams prior to deletion.

---

**2. Change Justification:**
GCP IP address pools are nearing exhaustion. Reclaiming unused subnets is essential to recover space, reduce clutter, and support new service provisioning (e.g., GKE, Composer, AI Notebooks).

---

**3. Benefits & Impact If Not Implemented:**

* **Benefits:** Frees up IP ranges, avoids quota exhaustion, enables faster provisioning, reduces Terraform state complexity.
* **Impact If Not Done:** Resource provisioning delays, subnet quota issues, unmanaged network bloat, and security risks from stale subnets.

---

**4. Known Defects:**
No code defects are associated with this change.

---

**5. Monitoring/Alerting Adjustments:**
No monitoring/alerting changes are required as subnets are idle and not in use.

---

**6. Blast Radius (Potential Impact):**
Minimal. Only stale subnets with no resources are being removed. App teams have validated all deletions. Any prod subnets reclaimed have confirmed sign-off.

---

**7. Post-Change Validation Plan:**

* Confirm subnet removal from GCP console and Terraform state
* Verify updated project provisioning repo
* Confirm no impact on active services (via monitoring)
* Update IP allocation tracker

---

**8. Communications Plan:**

* App teams notified via email (with 5 business days to respond)
* Approved subnet deletions logged and shared with Ops/NetEng
* No customer/business-facing impact expected

---

**9. Implementation Plan (Steps):**

1. Identify and validate subnets
2. Delink subnets from service project (project provisioning repo)
3. Raise and merge PR in networking repo
4. Raise CR and apply change post-approval
5. Update subnet/IP sheet post-implementation

---

**10. Backout Plan (High-Level):**
If required, subnet can be re-provisioned via intake request. No irreversible infra changes. Detailed rollback documented in network team wiki: `LINK_TO_BACKOUT_DOC`.

---

**11. Rollback Limitations:**
No major limitations. Subnets are safely reprovisionable as needed.

---

**12. Fail-Forward Deployment:**
No. This change is not designed to fail forward. Full rollback is possible.

---

### 📦 **Components (Add all applicable):**

* GCP Subnets
* Terraform Networking
* Project Provisioning Repository
* Intake/CR Workflow
* App Team Coordination
* IP Management

---

Let me know if you'd like this exported as a Jira-compatible `.txt` or markdown template.
