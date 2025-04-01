Here’s how you can write this requirement as a Jira story or task:

⸻

Title:
Create Cloud Logging Sink with BigQuery as Destination Using Terraform

⸻

Description:
We need to implement a Google Cloud Logging sink that captures specific logs (e.g., from GCE instances) and routes them into a BigQuery dataset for further analysis and reporting. The setup must be automated using Terraform and follow infrastructure-as-code best practices.

⸻

Acceptance Criteria:
	1.	A Terraform script is created to:
	•	Create a BigQuery dataset (if it doesn’t already exist).
	•	Create a logging sink at the project level.
	•	Assign appropriate IAM roles to allow the logging sink to write logs to the BigQuery dataset.
	2.	The sink should:
	•	Use a filter (e.g., resource.type=gce_instance) to capture only relevant logs.
	•	Automatically use a unique writer identity (service account).
	•	Have permissions granted to the sink’s service account on the BigQuery dataset.
	3.	The solution should include:
	•	Reusable variables for project ID, region, dataset ID, and log filter.
	•	Output the sink service account and dataset info for visibility.

⸻

Additional Notes:
	•	Running terraform apply might be required twice due to dependency on the generated service account.
	•	Include appropriate comments in the code for clarity.

⸻

Let me know if you want subtasks created for this or want to adapt this for folder/org-level sinks.
