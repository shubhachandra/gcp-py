from google.cloud import recommender_v1
import csv

PROJECT_ID = 'your-gcp-project-id'
LOCATION = 'global'
INSIGHT_TYPE = 'google.networkanalyzer.vpcnetwork.ipAddressInsight'
OUTPUT_CSV = 'subnet_utilization_report.csv'

parent = f"projects/{PROJECT_ID}/locations/{LOCATION}/insightTypes/{INSIGHT_TYPE}"

client = recommender_v1.RecommenderClient()
insights = client.list_insights(parent=parent)

csv_data = []

for insight in insights:
    insight_content = insight.content

    if insight.insight_subtype == "PRIMARY_IP_RANGE_UTILIZATION_HIGH":
        csv_data.append({
            "Subnetwork": insight_content.get("subnetwork"),
            "IP Address Range": insight_content.get("ipAddressRange"),
            "Allocation Ratio": insight_content.get("allocationRatio"),
            "Resources Using This Range": insight_content.get("resourcesUsingThisRange"),
            "Insight Subtype": insight.insight_subtype
        })

    elif insight.insight_subtype == "IP_UTILIZATION_SUMMARY":
        for subnet_info in insight_content.get("subnetRangePrefixes", []):
            csv_data.append({
                "Subnet Range Prefix": subnet_info.get("subnetRangePrefix"),
                "Allocation Ratio": subnet_info.get("allocationRatio"),
                "Insight Subtype": insight.insight_subtype
            })

    elif insight.insight_subtype == "PSA_IP_UTILIZATION_SUMMARY":
        csv_data.append({
            "PSA Range Prefix": insight_content.get("psaRangePrefix"),
            "PSA Subnet Prefix": insight_content.get("psaSubnetPrefix"),
            "PSA Subnet Region": insight_content.get("psaSubnetRegion"),
            "PSA Subnet Service": insight_content.get("psaSubnetService"),
            "Allocation Ratio": insight_content.get("allocationRatio"),
            "Insight Subtype": insight.insight_subtype
        })

if csv_data:
    csv_header = csv_data[0].keys()
    with open(OUTPUT_CSV, "w", newline="") as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=csv_header)
        writer.writeheader()
        writer.writerows(csv_data)
    print(f"Subnet utilization report saved to {OUTPUT_CSV}")
else:
    print("No subnet utilization insights found.")
