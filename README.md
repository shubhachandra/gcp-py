Here’s a polished and grammatically correct version of your summary statement, maintaining the technical accuracy and intent:

⸻

Summary of Terraform Customizations for Google-Provided Modules:

As per the Project Factory module, when subnets or shared subnets are passed in the list, all active API service agents are automatically granted the roles/compute.networkUser role at the subnet level.

We customized this behavior by adding service accounts to a group that already has the roles/compute.networkUser role at the subnet level, thereby simplifying IAM bindings.

If no subnets are provided, the module defaults to granting roles/compute.networkUser to the active API service agents at the host project level. We encountered the IAM policy binding limit (1500 bindings) in this scenario. To avoid this, we introduced a flag to prevent assigning this role at the host project level when groups are used instead.

In addition to the above:
	•	The roles/composer.ServiceAgentV2Ext role is granted to the Composer service account for using Composer with the Shared VPC host project.
	•	The roles/compute.networkAdmin role is granted to the Datastream service account to enable Datastream connectivity configuration on the Shared VPC host.
	•	We also created a custom role: roles/vpcaccess.user.

⸻

Would you like this formatted as a markdown doc, slide bullet points, or a comment block for code documentation?
