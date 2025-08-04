Here’s a structured capture of your update regarding Preetham’s involvement and the current status:

⸻

Update: Preetham - Week of Aug 4, 2025

Key Activities:
	•	Production & Non-Production Separation:
	•	This week is focused on the separation of prod and non-prod environments.
	•	A new scheduling Change Request (CR) is being coordinated with the Ops and SNS teams.
	•	Shweta has requested proper documentation before final approval.

Notebook Instances:
	•	All notebook instances are available for Richard to begin testing.

Milestones:
	•	Target closure date: 22nd August 2025
	•	Current schedule has been shared with Preetham.
	•	Preetham to share the same schedule with Harsha.

MASEC Implementation:
	•	Non-Prod MASEC: Scheduled for 18th and 20th August.
	•	Prod MASEC: Scheduled for 21st and 22nd August.
	•	MASEC is being executed in parallel with the environment separation.

Hybrid NAT Setup:
	•	No AppID is requested for prod and non-prod environments at this point.
	•	Hybrid NAT is only implemented in sandbox for now; will extend to prod/non-prod upon request.

⸻

Here’s a structured update for Sai’s tasks this week:

⸻

Update: Sai - Week of Aug 4, 2025

1. Reclamation Script Enhancement
	•	Assisting Hema in enhancing the reclamation scripts.
	•	Coordinating with application teams to obtain their approval for the updated logic.

2. Process & Intake Activities
	•	Opening intake requests as part of the approval and execution process.
	•	Updating PRs and maintaining mail approvals within the respective JIRA tickets.

3. Utilization Improvement
	•	Improved resource utilization compared to the last 2 weeks through better tracking and coordination.

4. TFE Migration
	•	Engaged in Terraform Enterprise (TFE) migration efforts.
	•	Encountered issues: Workspace in error state due to changes in grantable roles.
	•	Collaborating with Dele to resolve the role-based access problems.
	•	In the process of enabling roles and bringing the workspace to a stable migration state.

⸻

Here’s a structured summary of Hema’s tasks for the week:

⸻

Update: Hema - Week of Aug 4, 2025

1. Networking Diagram
	•	Working on the networking diagram.
	•	A draft version has been shared with Richard.
	•	Feedback from Richard: “Diagram is looking good.”

2. IPAM (IP Address Management)
	•	Currently working on IPAM requirements.
	•	A task tracker has been created and is being actively maintained.

3. Automation Cleanup
	•	Performing cleanup activities in automation scripts as part of ongoing improvements and optimizations.

⸻

Here’s a structured and professional summary of Shubh’s tasks and issues for the week:

⸻

Update: Shubh - Week of Aug 4, 2025

1. Prod Discovery & Environment Setup
	•	Prod discovery is in progress.
	•	Project creation is complete.
	•	VPC creation, including subnets and firewall rules, has been completed.
	•	Logging project and VPC Service Controls (VPC-SC) are pending.
	•	Meetings scheduled with both the VPC-SC team and Landing Zone team to proceed.
	•	CI environment for Prod Discovery is ready.
	•	PDisco environment is still pending.

2. Palo Alto Networking Setup
	•	Working on repo and workspace creation in AD-Ent for Palo Alto deployments.
	•	Post this, will initiate service project creation for Panorama.

⸻

3. Issue Tracking & Resolution

COTS:
	•	COTS team provided a solution excluding the Network Connectivity API.
	•	Rekha has ensured this exclusion in the implementation.

Prisma:
	•	All notebooks have been replaced.
	•	Workbench instances are ready and available for Richard.
	•	Service account deletion task completed to mitigate Prisma alerts, especially the account dedicated for Infoblox IPAM.

Sentinel:
	•	Encountered an issue with hard mandatory Sentinel enforcement.
	•	Discussed with Shashank and raised a ticket; the team is actively working on a fix.

Workspace Tag Change:
	•	Sentinel team requested to change the workspace tag from ad-ent-prod to ad-ent-sandbox.
	•	Richard approved the change.
	•	Ravi had a different view; clarification is being sought from the security team.

⸻

4. IPAM Work & Collaboration
	•	Continued work on the in-house IPAM tool:
	•	Requirement documentation completed.
	•	Tracker created.
	•	Collaborating with Hema on design and logic.
	•	Finalized the network topology diagram based on Richard’s feedback: “Looks good.”
	•	Collaborating with Hema and Sai for IP range requirements as part of the migration:
	•	App teams have requested 200+ subnets.
	•	Emphasis placed on subnet reclamation processes to meet demand.

⸻
