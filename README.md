Here is a JIRA Description Template tailored for your Prisma alert mitigation (Patch Solution 1) change request. It follows your provided questions and can be directly pasted into the JIRA “Description” field for clarity and completeness:

⸻

🔧 Change Description Template – Patch Solution 1: Remove Unnecessary Notebook Viewer Role

⸻

1. Description:

This change involves removing the roles/notebooks.viewer IAM role from service accounts attached to specific Vertex AI notebook instances in sandbox, non-prod, and prod environments. These service accounts already possess roles/notebooks.runner, which includes the necessary permissions provided by the viewer role, making the viewer role redundant.
Target instances include those ending with 737c, abc9, and 89e7 in prod-ad-ent, and similarly configured notebooks in sandbox and non-prod.

⸻

2. Change Justification:

The Prisma alerts are being triggered due to unnecessary elevated IAM permissions. The removal of the redundant role aligns with the principle of least privilege and ensures IAM compliance.

⸻

3. Benefits and Impact if Not Implemented:

Benefits:
	•	Eliminates unnecessary IAM permissions
	•	Reduces Prisma security alert noise
	•	Improves compliance with internal IAM best practices

Impact if not implemented:
	•	Continuous Prisma alerts for non-compliant permissions
	•	Increased operational overhead in managing false positives
	•	Security posture deviation from least privilege principle

⸻

4. Code Defects:

No code changes or defects are involved. This change is limited to IAM policy adjustments only.

⸻

5. Alerting and Monitoring Adjustments:

No changes to application-level alerting/monitoring. Prisma alert status will be used to validate the effectiveness of the IAM role removal.

⸻

6. Blast Radius:

Minimal. The changes only affect notebook instances’ service accounts. Since roles/notebooks.runner remains intact, notebook functionality will not be impacted.

⸻

7. Post-Change Validation and Checkout Plan:
	•	Post-change validation in sandbox with Prisma team to ensure alert suppression
	•	Verify notebook access and usability post IAM role removal
	•	Proceed with non-prod and prod changes only after successful validation

⸻

8. Communications:
	•	Notify GCP IAM governance team, Prisma monitoring team
	•	Communicate change window and status via Slack/Teams channels used by Operations and Command Centers
	•	Include summary update in the daily change call

⸻

9. High-Level Implementation Plan:
	1.	Identify service accounts with redundant roles
	2.	Create and approve PR to remove roles/notebooks.viewer
	3.	Apply changes to sandbox
	4.	Validate with Prisma team
	5.	Raise CR and apply changes to non-prod
	6.	Apply to prod with 2-day lead time post-approval

⸻

10. Backout Plan:

If any issues arise, reassign the roles/notebooks.viewer role to the impacted service accounts via a rollback script or reapply the original IAM bindings.
Reference rollback steps: [Confluence/Runbook link or Git repo]

⸻

11. Rollback Constraints:

No known constraints. IAM bindings can be re-applied without downtime.

⸻

12. Fail-Forward:

No. This is not a fail-forward change. The system can be safely rolled back without impact.

⸻

📦 Components Involved:
	•	Vertex AI Notebook Instances
	•	GCP IAM Policies
	•	Prisma Security Monitoring
	•	Change Management System (CR intake)

⸻

Let me know if you’d like this formatted into a JIRA Story + linked Sub-Tasks format or need a markdown/confluence version.
