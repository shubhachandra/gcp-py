Got it — you’re:
	•	Replacing deprecated user-managed notebooks in us-central1 and us-east1 with Vertex AI Workbench instances in the same regions.
	•	Creating two new Workbench instances in us-south1 and us-east4 (yes, us-east4 is both replacement and new — likely different use cases or SDLCs).

Here is your revised JIRA ticket description:

⸻

Title: Replace Deprecated Notebooks and Create New Vertex AI Workbench Instances for Routing Validation

⸻

Description:

To support ongoing routing validation efforts for Nonprod and Sandbox separation and BGP routing updates, we are replacing deprecated user-managed notebooks with Vertex AI Workbench instances and deploying new ones for extended use across SDLC environments.

This setup is critical for validating routing entity updates across on-prem and GCP environments.

⸻

Scope of Work:

1. Replacement of Deprecated Notebooks:
	•	Replace existing user-managed notebooks in:
	•	us-central1
	•	us-east1
with Vertex AI Workbench instances in the same regions.

2. Creation of New Workbench Instances:
	•	Create new Vertex AI Workbench instances in:
	•	us-south1
	•	us-east4
for enhanced routing validation coverage and environment separation.

3. Key Management Setup:
	•	For each SDLC environment (Sandbox, Nonprod, Prod):
	•	Create KMS keyrings and keys in respective regions (us-central1, us-east1, us-south1, us-east4).
	•	Integrate these keys with the new Workbench instances for encryption and compliance.

4. Repeatable Setup Across SDLCs:
	•	Apply the above steps uniformly across all SDLC environments:
	•	Sandbox
	•	Nonprod
	•	Prod

⸻

Justification:
	•	Legacy notebooks are deprecated and must be replaced for continued support and functionality.
	•	Routing validation is critical for safe deployment of networking changes.
	•	New Workbench instances allow for improved coverage and environment segregation.
	•	Proper key management ensures security and compliance.

⸻

Impact if Not Implemented:
	•	Routing validation efforts may stall due to deprecated tooling.
	•	Risk of errors in routing configurations due to lack of SDLC isolation.
	•	Non-compliance with security standards without proper KMS integration.

⸻

Dependencies:
	•	Vertex AI Workbench API access and IAM configuration.
	•	Coordination with networking and security teams for routing validation steps and KMS policy setup.

⸻

Let me know if you’d like this broken down into subtasks or formatted for a change request template.
