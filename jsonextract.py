from google.cloud import logging_v2
import pandas as pd
import re

PROJECT_ID = 'your-gcp-project-id'
NETWORK_NAME = 'your-network-name'
OUTPUT_CSV = 'subnet_utilization_report.csv'

# Initialize Cloud Logging client
logging_client = logging_v2.Client(project=PROJECT_ID)

# Define filter to retrieve Network Analyzer logs
log_filter = (
    f'logName="projects/{PROJECT_ID}/logs/networkanalyzer.googleapis.com%2Fanalyzer_reports" '
    f'resourceName="//compute.googleapis.com/projects/{PROJECT_ID}/global/networks/{NETWORK_NAME}"'
)

# Retrieve log entries sorted by timestamp (latest first)
entries = logging_client.list_entries(filter_=log_filter, order_by=logging_v2.DESCENDING)

latest_entry = next(iter(entries), None)

if latest_entry:
    json_payload = latest_entry.payload
    ip_utilization_info = json_payload.get('ipUtilizationInfo', [])

    subnet_data = []
    for info in ip_utilization_info:
        subnet_uri = info.get('subnetUri', 'Unknown')
        allocation_ratio = info.get('allocationRatio', 'N/A')

        # Extract project, region, and subnet name from subnet URI
        match = re.match(r'//compute.googleapis.com/projects/(.*?)/regions/(.*?)/subnetworks/(.*)', subnet_uri)
        if match:
            project, region, subnetwork = match.groups()
            subnet_data.append({
                'Project': project,
                'Region': region,
                'Subnetwork': subnetwork,
                'Allocation Ratio': allocation_ratio
            })

    # Create DataFrame and export to CSV
    subnet_df = pd.DataFrame(subnet_data).drop_duplicates()
    subnet_df.to_csv(OUTPUT_CSV, index=False)

    print(f"Subnet utilization report saved to {OUTPUT_CSV}")
else:
    print("No log entries found.")
