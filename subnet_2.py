import csv
from google.cloud import compute_v1

def list_shared_vpc_subnets(host_project_id, output_file="shared_vpc_subnets.csv"):
    client = compute_v1.SubnetworksClient()
    regions_client = compute_v1.RegionsClient()

    # Get all regions in the host project
    regions = [r.name for r in regions_client.list(project=host_project_id)]

    subnets_data = []

    for region in regions:
        request = compute_v1.ListSubnetworksRequest(project=host_project_id, region=region)
        for subnet in client.list(request=request):
            # Primary CIDR Range
            primary_cidr = subnet.ip_cidr_range

            # Handling Secondary CIDR Ranges
            if subnet.secondary_ip_ranges:
                for sec_range in subnet.secondary_ip_ranges:
                    subnets_data.append([
                        subnet.name,                        # Subnet Name
                        region,                            # Region
                        subnet.network.split('/')[-1],     # Network Name
                        primary_cidr,                      # Primary CIDR
                        sec_range.range_name,              # Secondary Range Name
                        sec_range.ip_cidr_range,           # Secondary CIDR Range
                        subnet.network.split('/')[1]       # VPC Project ID
                    ])
            else:
                # If no secondary range, write a single row with 'N/A' for secondary
                subnets_data.append([
                    subnet.name,                         # Subnet Name
                    region,                              # Region
                    subnet.network.split('/')[-1],      # Network Name
                    primary_cidr,                       # Primary CIDR
                    "N/A",                              # No Secondary Range Name
                    "N/A",                              # No Secondary CIDR Range
                    subnet.network.split('/')[1]        # VPC Project ID
                ])

    # Write data to CSV file
    with open(output_file, mode="w", newline="") as file:
        writer = csv.writer(file)
        writer.writerow(["Subnet Name", "Region", "Network", "Primary CIDR", "Secondary Range Name", "Secondary CIDR", "VPC Project"])
        writer.writerows(subnets_data)

    print(f"CSV file generated: {output_file}")

# Replace with your host project ID
host_project_id = "your-host-project-id"
list_shared_vpc_subnets(host_project_id)
