Certainly, Shubh! Here’s the updated Confluence page with the open question removed, and the answer integrated into Point 4 — including a clear explanation of the action taken: using a custom module to add service agents to the group profile.

⸻

🧾 IAM Binding Strategy for Shared VPC Host Projects (Post Project Factory v4.2.2)

📌 Overview

This document outlines the updated IAM binding strategy applied to Shared VPC host and service projects starting from Project Factory version 4.2.2 and above. These changes address legacy access concerns, enforce least privilege, and introduce a Google-native group-based subnet access model.

⸻

✅ Key Changes & Clarifications

⸻

1. Host Project Access — No More compute.networkUser at Host Level

Previous Behavior:
Shared VPC host projects had broad compute.networkUser bindings at the project level, granting access to all subnets.

Current Behavior (Post v4.2.2):
	•	We no longer assign compute.networkUser at the host VPC level.
	•	Subnet-level IAM roles are used instead.
	•	Google-native groups are created in each networking spoke repository and granted access to specific shared subnets.
	•	During provisioning, Project Factory v4.2.2+ automatically adds the required service agents to these groups based on the project’s needs.

⸻

2. Subnet Access in Service Projects — Region-Specific and Strictly Scoped

Previous Behavior:
All shared subnets were passed using a common locals block, giving service projects access to all subnets by default.

Current Behavior:
	•	We now maintain four dedicated shared subnets in:
	•	us-central1, us-east1, us-east4, and us-south1
	•	Subnet IAM roles are defined in the networking repo, and mapped to Google-native groups.
	•	Instead of using locals, we define dedicated variables per project in the provisioning code.
	•	When a new service project is created (e.g., for GKE or Composer):
	•	It uses a region-specific subnet, explicitly passed in code.
	•	Only the assigned subnet’s IAM role is granted to the project’s service agent — not all subnets.

⸻

3. Deprecated Use of Host Project IAM Bindings for Principals

Previous Behavior:
About 821 principals were granted the compute.networkUser role on Shared VPC host projects, acting as de facto service project admins.

Current Behavior:
	•	This model has been deprecated.
	•	No direct IAM bindings exist at the host project level.
	•	IAM roles are applied only at the subnet level, via group-based bindings, enforcing better separation of duties and scope.

⸻

4. Subnet-Level IAM Bindings — Group-Based (~7,538 Bindings)
	•	We currently maintain approximately 7,538 subnet-level compute.networkUser IAM bindings.
	•	These are enforced using Google-native groups, with each group mapped to a specific shared subnet.
	•	These groups are:
	•	Populated with required service agents during project provisioning.
	•	Scoped only to shared subnets, not application-specific or dedicated subnets.

Implementation Detail:
To support this model, we have implemented a custom Terraform module that:
	•	Detects active service APIs in the project (e.g., Composer, Dataflow, Dataproc, Serverless VPC).
	•	Identifies the corresponding Google-managed service agents.
	•	Automatically adds those service agents to the appropriate group profile that has subnet-level IAM permissions.

This ensures that:
	•	Only required service agents have access to specific subnets.
	•	Access is tightly scoped to subnet boundaries.
	•	IAM policies remain minimal, secure, and audit-friendly.

⸻

📌 References
	•	Project Factory v4.2.2 Release Notes (Insert link)
	•	Networking IAM Configuration Template
	•	Subnet Allocation Policy
	•	GKE/Composer Onboarding Guide

⸻

Let me know if you want this version exported to PDF, Markdown, or Word, or formatted in Confluence Storage Format for direct import.
