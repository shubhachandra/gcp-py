Before the current release:
	•	Two service accounts were granted the Compute Network User role at the host project level.
	•	Two service agents were assigned the Serverless VPC Access User role in the host project.
	•	One service agent was part of the Composer Shared VPC Agent group.
	•	One service agent was included in the GKE Host Service Agent User group.
	•	Six service agents were added as members of the Subnet Access groups.

⸻

To summarize:
When a new project is added, one service account — tf-project-id@iam.gserviceaccount.com — is granted the Compute Network User role at the host VPC level. The remaining permissions are distributed across specific groups:
	•	1 in the Composer Shared VPC group
	•	1 in the GKE Host Service Agent User group
	•	2 in the Serverless VPC Access User group
	•	6 in the Subnet Access group

⸻

Let me know if you’d like this rewritten as a policy note, documentation snippet, or Terraform comment.
