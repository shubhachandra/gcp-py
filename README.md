Got it! Here’s the revised version including your new point about involving the Prisma team:

⸻

Issue Summary:

Prisma alerts are being triggered for three notebook instances in the prod-ad-ent environment — instances ending with 737c, abc9, and 89e7. These instances have the Notebook Viewer role assigned to their service accounts, which is inconsistent with other notebook instances across environments.

Similar issues have also been observed in non-prod and sandbox environments.

Root Cause:

The service accounts attached to these notebook instances have an additional roles/notebooks.viewer role. This is redundant because the service accounts already have the Notebook Runner role (roles/notebooks.runner), which includes all the necessary permissions from the Viewer role.

Proposed Solution:

Remove the roles/notebooks.viewer role from the affected service accounts. This change will not impact notebook operations, as the roles/notebooks.runner role provides the required permissions.

Next Steps:
	1.	Create a PR to remove the roles/notebooks.viewer role from the affected service accounts.
	2.	Submit an intake request along with a change record (CR) for applying the changes:
	•	Sandbox and Non-prod: Request immediate resolution.
	•	Production: Plan changes with a 2-day lead time.
	3.	After applying the changes in sandbox, we’ll need support from the Prisma team to validate if the alerts have been resolved. This will help confirm we are on the right resolution track before proceeding to non-prod and production.

⸻

Let me know if you’d like this in email format or confluence-ready text.
