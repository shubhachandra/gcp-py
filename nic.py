from google.cloud import recommender_v1
import csv
import os

# Set environment variable for credentials if not using ADC
# os.environ = "/path/to/your/service_account_key.json"

project_id = "your-project-id"
location = "global"
insight_type = "google.networkanalyzer.vpcnetwork.ipAddressInsight"
parent = f"projects/{project_id}/locations/{location}/insightTypes/{insight_type}"

client = recommender_v1.RecommenderClient()
insights = client.list_insights(parent=parent)

csv_data =
csv_header =

for insight in insights:
    insight_content = insight.content
    if insight.insight_subtype == "PRIMARY_IP_RANGE_UTILIZATION_HIGH":
        row = {
            "Subnetwork": insight_content.get("subnetwork"),
            "IP Address Range": insight_content.get("ipAddressRange"),
            "Allocation Ratio": insight_content.get("allocationRatio"),
            "Resources Using This Range": insight_content.get("resourcesUsingThisRange"),
            "Insight Subtype": insight.insight_subtype
        }
        if not csv_header:
            csv_header = list(row.keys())
        csv_data.append(row)
    elif insight.insight_subtype == "IP_UTILIZATION_SUMMARY":
        for subnet_info in insight_content.get("subnetRangePrefixes",):
            row = {
                "Subnet Range Prefix": subnet_info.get("subnetRangePrefix"),
                "Allocation Ratio": subnet_info.get("allocationRatio"),
                "Insight Subtype": insight.insight_subtype
            }
            if not csv_header:
                csv_header = list(row.keys())
            csv_data.append(row)
    elif insight.insight_subtype == "PSA_IP_UTILIZATION_SUMMARY":
        row = {
            "PSA Range Prefix": insight_content.get("psaRangePrefix"),
            "PSA Subnet Prefix": insight_content.get("psaSubnetPrefix"),
            "PSA Subnet Region": insight_content.get("psaSubnetRegion"),
            "PSA Subnet Service": insight_content.get("psaSubnetService"),
            "Allocation Ratio": insight_content.get("allocationRatio"),
            "Insight Subtype": insight.insight_subtype
        }
        if not csv_header:
            csv_header = list(row.keys())
        csv_data.append(row)

if csv_data:
    with open("subnet_utilization_report.csv", "w", newline="") as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=csv_header)
        writer.writeheader()
        writer.writerows(csv_data)
    print("Subnet utilization report saved to subnet_utilization_report.csv")
else:
    print("No subnet utilization insights found.")
