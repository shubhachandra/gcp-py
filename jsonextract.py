import pandas as pd
import re

INPUT_JSON = 'subnet_logs.json'
OUTPUT_CSV = 'subnet_details_report.csv'

# Read JSON file as text
with open(INPUT_JSON, 'r') as json_file:
    json_text = json_file.read()

# Regex pattern to extract required parts
pattern = re.compile(
    r'"subnetUri":"//compute.googleapis.com/projects/(?P<project>[^/]+)/regions/(?P<region>[^/]+)/subnetworks/(?P<subnetwork>[^"]+)".*?"allocationRatio":(?P<ratio>[\d\.]+)',
    re.MULTILINE
)

# Extract matches
matches = pattern.findall(json_text)

# Create a structured data list
structured_data = []
for match in matches:
    project, region, subnetwork, ratio = match
    structured_data.append({
        'Project': project,
        'Region': region,
        'Subnetwork': subnetwork,
        'Allocation Ratio': ratio
    })

# Convert to DataFrame and export to CSV
subnet_df = pd.DataFrame(structured_data)
subnet_df.to_csv(OUTPUT_CSV, index=False)

print(f"Subnet details extracted and saved to {OUTPUT_CSV}")
