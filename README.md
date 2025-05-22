Title: Add IAM Roles to Specific Groups to Mitigate 400 Error from IAM Policy Limit

Description:

We are hitting a hard limit of 1500 IAM bindings on some resources, resulting in 400 errors during deployments and operations. This is due to the high number of individual user/service account bindings across projects.

Tactical Resolution:

To mitigate this issue temporarily, we propose assigning the required IAM roles to specific groups instead of individual users. This will help reduce the number of bindings significantly.

Action Items:

Add the following roles to designated groups:

roles/compute.networkUser

roles/composer.sharedVpcAgent

roles/vpcaccess.user (Serverless VPC Access User)

roles/container.hostServiceAgentUser (GKE Host Agent User)

Purpose:
This change is aimed at reducing IAM binding sprawl and mitigating the 400 error until a more permanent IAM design is implemented.

Priority: High (due to deployment blockers)

Impact if not done: Continued deployment failures, limited service functionality, and project delivery delays.

Assignee: [Assign appropriate team or individual]
Labels: IAM, GCP, AccessControl, BlockingIssue, TacticalFix
