Thanks! Here’s the updated meeting minutes with your tactical point added:

⸻

Meeting Minutes

Topic: Handling 1500 IAM Policy Bindings Limit in Host Project
Date: [Insert Date]
Attendees: [Insert Names if needed]

Key Observations:
	•	The 1500 IAM bindings limit was mitigated by shifting to the host project.
	•	A recent code fix successfully added service agents to the group.
	•	However, the non-prod network user limit is still not reducing as expected.

New Action Plan:
	1.	Create separate groups for different user roles.
	2.	When Project Factory adds service agents to the network, those should be moved to a group profile.
	3.	The tactical change is to move existing projects to the newer version of the Project Factory code.

Next Steps:
	•	Request the Ops team (Prakash) to initiate the migration of existing projects to the new version of Project Factory.
	•	Prakash will also coordinate with Vidha and raise the required Change Requests (CRs).
	•	Networking team to implement a similar model for other service agents, using group profiles to manage IAM limits.

⸻

Let me know if you’d like this in a specific format or added to an email draft.
