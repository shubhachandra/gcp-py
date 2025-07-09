Here’s the updated Jira story with placeholders for the 4 group names and the Terraform seed account name, so you can easily fill them in later:

⸻

📌 Jira Story: Grant Owner Role to Terraform Seed Service Account for IAM Group Management

Summary:
As a Network Engineer, I need the Terraform seed service account <TERRAFORM_SEED_SA_NAME> to be granted the Owner role so it can manage IAM group membership for GCP service agents like Composer and GKE through Terraform.

⸻

📋 Description:

We’ve made a strategic move to manage service agent IAM roles through predefined IAM groups rather than assigning roles directly. Each group has the required IAM role(s) attached, and service agents will inherit access through group membership.

The following groups are in use:
	1.	<COMPOSER_SERVICE_AGENT_GROUP>
	2.	<GKE_SERVICE_AGENT_GROUP>
	3.	<ADDITIONAL_GROUP_1>
	4.	<ADDITIONAL_GROUP_2>

To manage group membership through Terraform, the seed account <TERRAFORM_SEED_SA_NAME> must be granted the roles/owner (or a similarly privileged custom IAM role) at the required scope.

⸻

👤 As a: Network Engineer
🎯 I need: The Terraform seed service account to have the Owner role
💡 So that: It can automate adding service agents to IAM groups for Composer, GKE, etc.

⸻

✅ Acceptance Criteria:
	•	<TERRAFORM_SEED_SA_NAME> is granted roles/owner at project/folder/org level.
	•	The seed account can manage membership of:
	•	<COMPOSER_SERVICE_AGENT_GROUP>
	•	<GKE_SERVICE_AGENT_GROUP>
	•	<ADDITIONAL_GROUP_1>
	•	<ADDITIONAL_GROUP_2>
	•	Group membership updates via Terraform are tested and working.
	•	Any required security reviews or audits are completed.

⸻

⏱️ Estimated Effort: 2–4 hours
🏷️ Labels: IAM, Terraform, SeedAccount, NetworkEngineering
📁 Component: IAM Automation

⸻

Let me know if you’d like this as a CSV or want help filling in the actual names.
