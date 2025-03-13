import json
import csv

# Input and output file paths
input_json_file = "subnets.json"
output_csv_file = "subnets.csv"

# Load the JSON data
with open(input_json_file, "r") as json_file:
    subnets_data = json.load(json_file)

# Define the CSV headers
csv_headers = ["name", "region", "network", "ipCidrRange", "creationTimestamp"]

# Write to CSV file
with open(output_csv_file, "w", newline="") as csv_file:
    csv_writer = csv.DictWriter(csv_file, fieldnames=csv_headers)

    # Write header row
    csv_writer.writeheader()

    # Write data rows
    for subnet in subnets_data:
        csv_writer.writerow({
            "name": subnet.get("name", ""),
            "region": subnet.get("region", "").split("/")[-1],  # Extract region name
            "network": subnet.get("network", "").split("/")[-1],  # Extract network name
            "ipCidrRange": subnet.get("ipCidrRange", ""),
            "creationTimestamp": subnet.get("creationTimestamp", "")
        })

print(f"CSV file '{output_csv_file}' has been generated successfully.")
