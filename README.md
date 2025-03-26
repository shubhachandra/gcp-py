Minutes:

Sandbox environments will use subnet mask /27.

For all applications (production/non-production), the subnet mask /27 is insufficient due to the requirement of running 3 Composer instances per subnet.

Recommended subnet mask for non-production and production environments: /26 (covering test, SA, UAT, and saferoom).

Each subnet in non-production and production environments will accommodate:

2 development projects.

3 Composer instances per subnet.

Dataproc subnet allocations will require explicit requests from application teams.

Summary:

Sandbox: /27 subnet mask

Non-production/Production: /26 subnet mask (for test, SA, UAT, saferoom)

Dataproc: Requires explicit subnet allocation requests
Here’s a Confluence-friendly version of the Google Cloud Network Intelligence Center - Network Analyzer Implementation document. It includes proper formatting with headers, code blocks, and SQL styling to ensure readability.

⸻

Google Cloud Network Intelligence Center - Network Analyzer Implementation

Objective: Implement Google Cloud’s Network Analyzer to monitor subnet IP allocation, export data to BigQuery, and visualize subnet utilization with a BI tool.

⸻

1. View IP Address Allocation & Set Up Logging in Network Analyzer

Steps:
	1.	Go to Google Cloud Console.
	2.	Navigate to Network Intelligence Center → Network Analyzer.
	3.	Click View to check IP address allocation percentage.
	4.	Click View Logs → Logs Explorer.
	5.	Create an Alert for subnet usage anomalies.
	6.	Copy the query used by Network Analyzer.
	7.	Create a Log Sink to export logs to BigQuery:
	•	In Logs Router, create a new sink.
	•	Set BigQuery as the destination.
	•	Choose the appropriate dataset in BigQuery.

⸻

2. Retrieve Subnet Details from Cloud Asset Inventory

Steps:
	1.	Go to Cloud Asset Inventory in Google Cloud Console.
	2.	Click on Resources and select compute.subnetwork.
	3.	Click on Asset Query.
	4.	Run the following SQL query:

SELECT * FROM compute_googleapis_com_Subnetwork;


	5.	Click Run.
	6.	Export results to a CSV file and save it locally.

⸻

3. Create a BigQuery Table & Upload CSV

Steps:
	1.	Go to BigQuery Console.
	2.	Select or create a new dataset.
	3.	Click Create Table.
	4.	Select Upload CSV file and choose the subnet CSV file.
	5.	Schema definition:
	•	subnetwork_name (STRING)
	•	ip_cidr_range (STRING)
	•	region (STRING)
	•	creation_timestamp (TIMESTAMP)
	•	Other relevant fields as per exported data.
	6.	Click Create Table.

⸻

4. Join Tables & Filter Old Subnets

SQL Query:

SELECT 
    n.subnetwork_name, 
    n.region,
    c.creation_timestamp,
    TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), c.creation_timestamp, DAY) AS subnet_age_days,
    n.allocated_ip_ratio,
    CASE 
        WHEN n.allocated_ip_ratio > 80 THEN 'High Utilization'
        WHEN n.allocated_ip_ratio BETWEEN 50 AND 80 THEN 'Moderate Utilization'
        ELSE 'Low Utilization'
    END AS utilization_category
FROM `your_project.your_dataset.network_analyzer_logs` n
JOIN `your_project.your_dataset.subnet_inventory` c
ON n.subnetwork_name = c.subnetwork_name
WHERE TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), c.creation_timestamp, DAY) > 90;

Steps:
	1.	Join Network Analyzer logs (sink data) with Cloud Asset Inventory subnet data on subnetwork_name.
	2.	Filter subnets older than 3 months.
	3.	Calculate IP allocation ratio.
	4.	Store results in a new BigQuery table.

⸻

5. Visualize Subnet Utilization Using BI Tool

Steps:
	1.	Open a BI tool (Looker Studio, Power BI, or Tableau).
	2.	Connect to BigQuery and select the joined table.
	3.	Create a dashboard with:
	•	Pie chart: Used vs. Unused Subnet Ratio.
	•	Bar chart: Subnet Utilization Category (High, Moderate, Low).
	•	Table: Oldest subnets with low utilization for optimization.
	4.	Publish the report & schedule auto-refresh.

⸻

Conclusion

✅ Automated monitoring of subnet IP allocation.
✅ Historical tracking with Cloud Asset Inventory.
✅ Actionable insights on subnet utilization.
✅ BI-based visualization for better decision-making.

By integrating Google Cloud Network Analyzer, BigQuery, and BI tools, teams can efficiently monitor and optimize their subnet utilization.

⸻

This version is Confluence-ready, well-structured, and formatted for readability with proper styling for headers, code blocks, and bullet points.
