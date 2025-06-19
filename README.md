Here is a revised and clearer version of your sentence:

⸻

All service agents are now members of their respective groups, each of which already has the appropriate IAM roles assigned:
	•	The tf-project-* service account now correctly appears in the subnet networking group, which has the compute.networkUser role.
	•	The gcp-as-notebook service account is also added to the subnet SA group.
	•	Both the tf-project-id service account and the serverless-robot-prod-iam service account are added to the Serverless VPC Access User group, which has the vpcaccessuser role.
	•	The container-engine-robot service account is added to the GKE Host Service Agent group, which has the roles/container.hostServiceAgentUser role.
	•	The Composer service agent is added to the Composer Service VPC Agent group, which has the roles/composer.sharedVpcAgent role.
	•	All remaining service accounts for active APIs have also been added to the subnet group.

⸻

Let me know if you want a more concise or more technical version (e.g., for documentation or change request).
