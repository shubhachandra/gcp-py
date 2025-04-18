Here's a well-structured Jira story to address the GCP policy binding limit by using a group profile:

---

**Title:**  
Mitigate GCP Policy Binding Limit (1500 Members) by Using Group Profile for `roles/compute.networkUser` in Core SDLC

---

**Description:**  
GCP IAM policies have a limitation of 1500 principals per role binding. In our current setup, individual service accounts are granted the `roles/compute.networkUser` role at the subnet level within the **Core SDLC**, leading to policy updates failing as we reach this limit.

To mitigate this issue, we propose the creation of a **central group profile** that will include all relevant service accounts as members. This group will then be granted the `roles/compute.networkUser` role at the Core subnet level. This approach simplifies IAM management and avoids exceeding the policy binding limit.

---

**Acceptance Criteria:**

1. A new Google Group is created for Core SDLC subnet access (e.g., `gcp_gcp_core_subnet_sa_ComputeNetworkUser@domain.com`).
2. All service accounts that require `compute.networkUser` access are added as members of this group.
3. The group is granted the `roles/compute.networkUser` IAM role at the subnet level within the Core SDLC VPC.
4. Terraform code is updated to reflect this group-based role assignment.
5. Validate that the role is successfully applied and IAM policy binding size is within GCP limits.
6. Add documentation on:
   - How to request access (i.e., adding new service accounts to the group).
   - Ownership and maintenance of the group.

---

**Justification:**  
- Prevents policy update failures due to GCP's 1500 member IAM binding limit.  
- Ensures scalability for future subnet access requests.  
- Reduces operational overhead by centralizing IAM access control.

---

**Impact if Not Implemented:**  
- Future Terraform runs may fail for project provisioning and subnet access.  
- Manual workaround may increase IAM misconfiguration risk and operational delays.

---

Let me know if you want a subtasks breakdown or Terraform code snippet included in the story.
