The network-py2y.json file is enabling logging for DNS managed zones. Ruth Icon was working on this, but since the applied changes failed, they had to revert them, and I will coordinate with him further.

On networking-1fd7, most of the firewall rules were created by GKE, and logging is disabled by default. We should add Terraform code to enable firewall logging at the time of creation, ensuring logging is enabled by default. This task should be moved to the Landing Zone team, as they manage the default logging values.

For GKE-created firewall rules,

In network-c510.json, we 




* The provisioning will be done using the project provisioning repo
* Ensure naming conventions and organization policies are followed
* Validate connectivity between the service projects and the Shared VPC

**Priority:** High

---

If you’d like, I can help you expand it with more technical details (like subnet names, IAM roles, folder IDs, etc.) — just let me know!
