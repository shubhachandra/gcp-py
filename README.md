Here's the **fully filled change request template** based on your provided context:

---

### 1. Change Title / Summary

**non-prod - BLADE-AWG - Bind `compute.networkUser` role to Google Group**

---

### 2. Change Type

**Standard**

---

### 3. Change Category

**Infrastructure**

---

### 4. Priority

**High**

---

### 5. Linked Engineering Jira (QA Completed)

**Reference Jira:** ENG-1234 – Routing update completed for QA network hub.

---

### 6. Pull Request Information

**PR Link:** [https://github.com/org/repo/pull/5678](https://github.com/org/repo/pull/5678) *(Replace with actual PR link)*

---

### 7. Support Documentation

**Confluence Page:** [Confluence Documentation – Notebook Subnet Access Role Binding](https://confluence.company.com/display/GCP/NotebookSubnetRoleBinding) *(Replace with actual page)*

---

### 8. Change Description

#### 1. Description

Bind the IAM role `roles/compute.networkUser` to the Google Group `GCP_GCP_NOTEPROD_AINOTEBOOK_SUBNET_SA_COMPUTENetworkuser`. This role binding applies to the `/20` shared subnets created for AI/Colab notebooks in **us-central1** and **us-east1** regions. This enables access to shared VPC subnets for all projects under the **Blade** folder to support Notebook instance creation via CLI or UI.

#### 2. Change Justification

The `compute.networkUser` role is granted to the Google Group to allow data engineers, data scientists, and analysts—added by the resource owner—to consume AI Notebooks within the shared subnet. This aligns with project policies for centralized access control using group membership.

#### 3. Benefits / Impact

* Enables centralized, scalable access to shared subnets for notebook users.
* Simplifies access control via Google Group membership.
* Unblocks Colab/AI Notebook deployments in non-prod environments.

#### 4. Known Defects

* **None.** Configuration changes have been validated in QA. Clean rollout expected.

#### 5. Alerting and Monitoring

* No new alerting rules required.
* Existing flow logs and NOC dashboards will be monitored post-change for unexpected traffic or route issues.
* Alerting remains under current monitoring SLAs.

#### 6. Blast Radius

* **Internal Only:**

  * Applies only to non-production environment under Blade folder.
  * Limited to subnet-level IAM permissions; no broader project-level access changes.

#### 7. Post-Change Validation

* Validate notebook creation in both `us-central1` and `us-east1`.
* Confirm successful binding via `gcloud projects get-iam-policy`.
* Ensure users from the group can launch notebooks without permission issues.
* Confirm NOC dashboard does not show traffic drops or failures.

---

### 9. Communication Plan

* Notify **Networking Operations** team before change execution and confirm after.
* Engineering stakeholders have been informed via Microsoft Teams and follow-up email.
* No external or user-facing communication required.

---

### 10. Implementation Steps

1. Confirm group membership in `GCP_GCP_NOTEPROD_AINOTEBOOK_SUBNET_SA_COMPUTENetworkuser`.
2. Use Terraform or `gcloud` to bind `roles/compute.networkUser` to the specified subnets.
3. Validate binding via IAM policy inspection.
4. Test notebook creation from one sample project.
5. Notify stakeholders of successful implementation.

---

### 11. Backout Plan

1. Remove IAM binding for the Google Group from the affected subnets.
2. Revert Terraform/PR changes.
3. Validate that access is revoked via notebook creation tests.
4. Notify stakeholders of rollback status.

---

### 12. Rollback Limitations

* IAM binding changes typically take effect within seconds, but rollback may be delayed if cached permissions are in use.
* Users who have already started notebooks may retain access temporarily until VM is deleted.

---

### 13. Fail-Forward Strategy

* If binding partially fails (e.g., one region), proceed to apply manually or retry automation.
* Escalate to IAM admin if role propagation delays are encountered.
* Continue notebook access rollout after issue resolution.

---

Let me know if you'd like this in a downloadable format (Markdown, Word, Confluence-ready, etc.).
