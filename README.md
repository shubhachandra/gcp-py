Here’s a well-structured business justification and business impact statement you can use or adapt:

⸻

Business Justification

There is an ongoing request to update existing infrastructure via Terraform in a non-production environment. As part of the update process, each service account is being granted the roles/compute.networkUser role at the project level. GCP IAM policies have a hard limit of 1,500 members per policy binding, and we have now reached or exceeded this limit.

This limitation is causing all Terraform updates to fail during policy modification steps, preventing further infrastructure changes in the non-prod environment. Without resolving this issue, any future changes—regardless of their criticality—will continue to fail.

⸻

Business Impact
	•	Blocked non-prod deployments: All Terraform-based deployments in non-prod environments are currently blocked, halting feature testing, validation, and QA activities.
	•	Risk of cascading failures: The same IAM policy structure is used in PROB and SANDBOX environments, which are likely to hit the same limit soon, leading to similar disruptions.
	•	Delayed development cycles: Without updates being pushed to non-prod, development teams are unable to test new features or bug fixes, directly impacting sprint velocity and release timelines.
	•	Compliance & cost risk: Stuck resources or partial deployments may incur unnecessary cloud costs or deviate from compliance baselines due to failed automation.

⸻

Recommendation

Refactor the IAM policy to reduce the number of members in a single binding. One suggested approach is to:
	•	Create GCP IAM groups and assign the networkUser role to the group instead of individual service accounts.
	•	Add service accounts to these groups dynamically via automation.

This will ensure we remain within policy limits and maintain flexibility and scalability for future updates.

⸻

Let me know if you’d like a version that can go into a ticket, email, or presentation format.
