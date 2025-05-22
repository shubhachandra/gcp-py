The "owner" mentioned refers to the group owner, who will manage group membership by adding service agents and service accounts using Terraform automation.

The Composer Shared VPC group will be used by Cloud Composer instances to access the Shared VPC.

The Serverless VPC Access User role will be granted to a group containing the relevant service agents, enabling them to access Serverless VPC connectors.

Similarly, the GKE Host Service Agent User role will be granted to a group to allow GKE service agents to operate with the required permissions.

Currently, these roles are directly assigned to individual service agents at the Host VPC project level, which has led to reaching the hard limit of 1500 IAM policy bindings, resulting in 400 errors.

To mitigate this, we plan to move the service agents into respective groups, and assign IAM roles to these groups instead of individual service accounts. This is a tactical solution to reduce IAM bindings and resolve the errors temporarily while we work on a more scalable long-term solution.

