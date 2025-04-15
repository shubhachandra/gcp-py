Here’s a polished Jira ticket content you can use to document your request to delete subnets, along with justification and usage evidence:

⸻

Title: Request for Deletion of Unused Test Subnets

Description:
This request is to delete the following subnets which were provisioned for testing purposes and are no longer in use. The subnets show minimal usage and hold no active workload or application dependency.

Subnet(s) to Delete:
	•	subnet-name-1 (e.g., test-subnet-usc1-100-126-100-0-24)
	•	subnet-name-2 (if applicable)

Justification:
	1.	These subnets were originally created for short-term testing or evaluation purposes.
	2.	Network Analyzer report shows only 8% usage, with the following breakdown:
	•	1 IP is reserved but not assigned to any resource
	•	1 IP is used by the Internet Gateway
	•	1 IP is the Broadcast address
	•	1 IP is the Network address
	3.	No active compute or managed services (like GKE, notebooks, etc.) are associated with these subnets.
	4.	Retaining these unused subnets blocks valuable IP space, which could be repurposed for production or sandbox environments.

Evidence:
	•	Attached Network Analyzer screenshot confirming subnet utilization and absence of active resources.

Impact:
Deleting these subnets will help reclaim IP ranges and reduce clutter. As there are no dependencies, the risk is minimal.

Next Steps:
	•	Validate deletion with LZ/network team.
	•	Reclaim associated IP range back to the available pool.
	•	Update documentation and subnet inventory records accordingly.

Attachments:
	•	network-analyzer-subnet-usage.png

⸻

Let me know if you’d like a version broken down into Jira custom fields like Acceptance Criteria, Impact, or Checklist as well.

