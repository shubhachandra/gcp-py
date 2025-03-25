Solution Document: Implementing Google Cloud Network Intelligence Center - Network Analyzer with BigQuery and BI Integration

Overview

This document outlines the steps to implement Google Cloud Network Intelligence Center - Network Analyzer and integrate its insights with BigQuery for analytics and a BI tool for visualization. The process includes retrieving subnet allocation data, exporting it to BigQuery, joining it with Cloud Asset Inventory subnet details, and visualizing subnet utilization.

⸻

Implementation Steps

Step 1: Use Network Analyzer to View IP Address Allocation & Set Up Logging
	1.	Navigate to Google Cloud Console → Network Intelligence Center → Network Analyzer.
	2.	Click on View for a summary of IP address allocation percentage of subnet ranges.
	3.	Click on View Logs and go to Logs Explorer.
	4.	In Logs Explorer, create an alert based on the Network Analyzer logs.
	5.	Copy the query used by Network Analyzer for IP allocation insights.
	6.	Create a log sink to export these logs to BigQuery:
	•	In Logs Router, create a new sink.
	•	Set BigQuery as the destination.
	•	Choose the appropriate dataset in BigQuery.

⸻

Step 2: Retrieve Subnet Details from Cloud Asset Inventory
	1.	In Google Cloud Console, go to Cloud Asset Inventory.
	2.	Click on Resources and select compute.subnetwork.
	3.	Click on Asset Query.
	4.	Run the following query in Asset Query:

SELECT * FROM compute_googleapis_com_Subnetwork;


	5.	Click on Run.
	6.	Export the results to a CSV file and save it locally.

⸻

Step 3: Create a Table in BigQuery & Upload CSV
	1.	Navigate to BigQuery in Google Cloud Console.
	2.	Create a new dataset (if not already created).
	3.	Click on Create Table.
	4.	Select Upload CSV file as the source and choose the previously exported subnet details CSV file.
	5.	Define the schema:
	•	subnetwork_name (STRING)
	•	ip_cidr_range (STRING)
	•	region (STRING)
	•	creation_timestamp (TIMESTAMP)
	•	other relevant fields as per exported data
	6.	Click on Create Table.

⸻

Step 4: Join Tables & Filter Old Subnets
	1.	Create a new table in BigQuery to store joined data.
	2.	Use the JOIN function to merge the Network Analyzer logs (sink data) with the Cloud Asset Inventory subnet table on subnetwork_name.
	3.	Use a filter to identify subnets older than 3 months.
	4.	Compute the IP allocation ratio for each subnet.
	5.	Example SQL query:

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


	6.	Save the results in a new BigQuery table for further analysis.

⸻

Step 5: Visualize Subnet Utilization Using BI Tool
	1.	Open a BI tool (Looker Studio, Power BI, or Tableau).
	2.	Connect to BigQuery and select the joined table.
	3.	Create a dashboard with:
	•	A pie chart showing used vs. unused subnet ratio.
	•	A bar chart displaying subnet utilization category (High, Moderate, Low).
	•	A table listing oldest subnets with low utilization for optimization.
	4.	Publish the report and schedule automatic updates.

⸻

Conclusion

This implementation enables:
	•	Automated monitoring of subnet IP allocation.
	•	Historical subnet tracking with Cloud Asset Inventory.
	•	Actionable insights on subnet utilization for optimization.
	•	BI-based visualization for better decision-making.

By following these steps, Google Cloud Network Analyzer logs are effectively analyzed, stored in BigQuery, and visualized through a BI tool, helping teams optimize their network resources.
