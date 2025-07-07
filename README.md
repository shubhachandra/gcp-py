Of course! Here’s a complete, detailed Confluence page draft you can copy-paste directly into your Confluence workspace. It is structured clearly with headings, tables, and actionable details.

⸻

🛰️ Subnet Reclamation Framework

Purpose

This page documents the Subnet Reclamation Framework to recover unused subnet IP ranges across SDLC environments. The objective is to maintain a sustainable, efficient, and future-proof IP address management process in response to growing IP shortages.

⸻

Background
	•	Our IP address pools are nearing exhaustion, impacting our ability to onboard new services such as GKE clusters, Composer, and AI Notebooks.
	•	A recent audit identified 230 unused subnets across SDLC environments.
	•	These subnets need to be reclaimed in a phased and controlled manner.

⸻

Objectives

✅ Optimize and recover valuable IP address ranges
✅ Support faster provisioning of future workloads
✅ Maintain a clean and secure network environment
✅ Build a foundation for future automation

⸻

Process Overview

Below is the detailed step-by-step process:

1️⃣ Subnet Usage Report Generation
	•	Daily subnet consumption reports generated from Grafana or equivalent
	•	Highlight subnets with no resources attached for 90+ days

⸻

2️⃣ Candidate Subnet Shortlisting
	•	Networking team reviews the report
	•	Shortlists candidate subnets for potential reclamation

⸻

3️⃣ App Team Validation
	•	Networking team directly contacts the application team
	•	Provides subnet details:
	•	Subnet name
	•	IP range
	•	SDLC environment
	•	Service project
	•	Days since last update
	•	Planned deletion timeline
	•	App team has 5 business days to respond with justification
	•	If no response and no active workloads, proceed with reclamation

⸻

4️⃣ Delinking Subnet from Service Project

Important prerequisite step before deletion:
	•	The subnet must be delinked from its associated service project
	•	This is done in the project provisioning repository, involving:
	•	Update the repo
	•	Commit and push changes
	•	Raise a Pull Request (PR)
	•	Raise an intake request
	•	Ops team creates a CR (Change Request)
	•	CR approved, merged, and applied
	•	Only once delinked, proceed to subnet deletion

Estimated time per subnet (for delinking + reclaim flow): ~1 hour 30 minutes

⸻

5️⃣ Subnet Reclamation (Delete)
	•	Network team raises an intake request for subnet deletion after delinking
	•	Ops team creates a CR for deletion of the subnet from Terraform
	•	CR is approved, merged, and applied
	•	Subnet is officially reclaimed

⸻

Roles & Responsibilities

Team	Responsibilities
Networking	Identify candidates, contact app teams, validate, raise intake requests
Ops	Create CRs, approve/merge/apply changes
App Teams	Respond to validation emails within 5 business days


⸻

Batching & Scheduling
	•	Initial volume: ~230 unused subnets
	•	Target: 15 subnets reclaimed per week (based on estimated processing effort)
	•	Proposed: dedicate one day per week (e.g., Wednesdays) for subnet reclamation
	•	CR lead times for production: currently 7 days
	•	Suggest to discuss possible lead time adjustment for faster execution

⸻

Future Automation Vision

Long-term, the goal is to fully automate this end-to-end process, including:

✅ Automated subnet reporting
✅ Automated validation with app owners
✅ Automated delinking workflow from the repo
✅ Automated PR generation and intake request
✅ Automated CR creation, approval, and apply
✅ Integrated dashboards for tracking status
✅ Audit trail and rollback support

⸻

Milestones

Milestone	Target Sprint
Process design and stakeholder sign-off	Sprint X
Pilot batch of 15 subnets	Sprint X+1
Weekly cadence established	Sprint X+2
Reporting dashboard creation	Sprint X+3
Automation PoC planning	Sprint X+4
Automation rollout	Sprint X+5 onward


⸻

Questions for Ops Team

1️⃣ Should subnet deletion intake requests be:
	•	one consolidated intake per SDLC
	•	or multiple intake requests per subnet?

2️⃣ Can we dedicate one weekday (Wednesday) for all subnet reclamation?

3️⃣ Would you support adjusting lead time (currently 7 days for production) if we dedicate a specific day for these activities?

4️⃣ Should we stick to 15 subnets per week or consider larger batch sizes?

⸻

Next Steps

✅ Gather Ops team feedback on above questions
✅ Schedule a discussion meeting
✅ Finalize the approach and stakeholder sign-off
✅ Start pilot execution

⸻

Contacts
	•	Networking Team: [name / email / Slack channel]
	•	Ops Team: [name / email / Slack channel]
	•	Project Owner: [name / email]

⸻

If you’d like, I can help you make this even more visually formatted for Confluence with tables, info panels, and status macros — just say:

“Format for Confluence with macros”

and I’ll adjust it for you!
