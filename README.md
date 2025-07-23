Here’s a well-structured JIRA story for your patch solution to suppress Prisma alerts (you can title it as Patch Solution 1 – Remove Unnecessary Viewer Role from Notebook Instances):

⸻

Story Title:

Patch Solution 1 – Remove Unnecessary Viewer Role from Notebook Instances to Mitigate Prisma Alerts

⸻

Story Description:

Prisma alerts have been observed for notebook instances across environments (sandbox, non-prod, and prod-ad-ent) due to service accounts having an unnecessary roles/notebooks.viewer IAM role. These accounts already have the roles/notebooks.runner role, which includes all required permissions.

This JIRA story aims to implement a patch solution by removing the redundant role and verifying the resolution with the Prisma team.

⸻

Scope:
	•	Identify affected notebook instances with the roles/notebooks.viewer role:
	•	Notebooks in prod-ad-ent: Instances ending with 737c, abc9, and 89e7
	•	Similar patterns observed in sandbox and non-prod
	•	Remove roles/notebooks.viewer IAM role from the attached service accounts

⸻

Tasks:
	1.	✅ Identify all affected notebook instances across environments
	2.	🛠 Create a PR to remove roles/notebooks.viewer from the identified service accounts
	3.	🧪 Apply changes in sandbox environment
	4.	🤝 Coordinate with Prisma team to validate if alerts are resolved post-change
	5.	📝 Submit intake request and CR to proceed with non-prod and production:
	•	Sandbox/Non-prod: Immediate resolution
	•	Production: Minimum 2-day lead time
	6.	🚀 Apply changes to non-prod and prod after validation
	7.	📘 Document the resolution and lessons learned

⸻

Acceptance Criteria:
	•	roles/notebooks.viewer removed from all identified service accounts
	•	Prisma alerts no longer triggered for the impacted notebook instances
	•	Verified with Prisma team post-change in sandbox
	•	Changes successfully rolled out to non-prod and prod
	•	CR records attached and deployment timelines followed

⸻

Let me know if you’d like a sub-task breakdown or if you’re using a specific JIRA template (like EPIC > Story > Task).
