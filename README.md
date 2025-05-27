Here’s a clear definition of expectations from the dashboard and the automation workflow you’re envisioning, broken into business, technical, and operational needs:

⸻

📊 Dashboard Expectations for Unused Subnet Monitoring

🎯 Objective

To track and manage unused subnets across GCP projects by:
	•	Identifying subnets without attached networking resources,
	•	Reporting usage patterns and creation timelines,
	•	Enabling proactive reclamation by notifying responsible app teams.

⸻

✅ 1. Subnet Usage Visibility

Goal: List all subnets with zero resource usage.

Expected Criteria:
	•	Subnet should not be attached to any of the following GCP resources:
	•	Compute Engine (VMs)
	•	GKE Clusters or Node Pools
	•	Load Balancers (internal or external)
	•	Cloud SQL Instances
	•	Cloud Filestore
	•	Vertex AI Notebooks / AI Platform
	•	Should also exclude subnets used in VPC Peering, Private Service Connect, or Shared VPC Attachments.

Dashboard View:

Subnet Name	Region	VPC	Project	Status	Attached Resource(s)	Owner Tag	Environment
subnet-abc	us-east1	vpc-prod	project-x	UNUSED	None	team-abc	prod


⸻

📅 2. Subnet Activity Insights

Goal: Track creation date and last activity timestamp for each subnet.

Expected Data Points:
	•	Created Date: Timestamp when subnet was first created.
	•	Last Activity Date: Last time any resource was provisioned on the subnet.
	•	Idle Duration: Number of days since last activity.

Dashboard View:

Subnet	Created Date	Last Active Date	Days Since Creation	Days Idle
subnet-abc	2023-11-15	N/A	560 days	560 days


⸻

🤖 3. Automation & Notification Pipeline

Goal: Automate detection and alerting of unused subnets.

Required API or Script Capabilities:
	•	List all subnets in all relevant projects (using gcloud or GCP API).
	•	For each subnet:
	•	Check for attached resources.
	•	Query audit logs (or asset inventory) to get last activity.
	•	Aggregate findings and tag owner or application team.
	•	Send email notifications to relevant application team(s) via:
	•	SMTP + Cloud Function
	•	Google Chat webhook or Slack (if enabled)
	•	Pub/Sub + Workflow + Email

Email Format (Example):

Subject: [Action Required] Unused Subnet Detected in Project-X

Dear Team,

The following subnet in your project appears to be unused for over 180 days:

Subnet: subnet-abc  
Region: us-east1  
Created: 2023-11-15  
Last Usage: Not Detected  
Idle for: 560 days  

Please confirm if this subnet can be deleted to free up IP capacity.

Thanks,  
Cloud Infra Team


⸻

🧩 Optional Enhancements
	•	Add filters by:
	•	Project, Region, Environment (dev/test/prod), Owner Tag.
	•	Integrate with BigQuery or Looker Studio for richer analytics.
	•	Add reclaim suggestions or create Jira tickets for actioning.

⸻

Let me know if you’d like a working Terraform or Python prototype, or a sample design of the dashboard (e.g., Looker Studio or Grafana).
