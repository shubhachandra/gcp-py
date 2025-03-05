from google.cloud import compute_v1

def get_instances_in_subnet(project_id, region, subnet_name):
    """
    Retrieves instances assigned to a specific subnet.
    
    :param project_id: GCP Project ID
    :param region: Region where the subnet is located
    :param subnet_name: Name of the subnet
    :return: List of instances within the subnet
    """
    instances_client = compute_v1.InstancesClient()
    instance_list = []

    # Get list of all instances in the region
    request = compute_v1.AggregatedListInstancesRequest(project=project_id)
    instances = instances_client.aggregated_list(request=request)

    for zone, instance_scope in instances:
        if "instances" in instance_scope:
            for instance in instance_scope["instances"]:
                # Check if the instance's network interface is in the given subnet
                for interface in instance.network_interfaces:
                    if subnet_name in interface.subnetwork:
                        instance_list.append({
                            "name": instance.name,
                            "zone": zone,
                            "subnet": interface.subnetwork,
                            "network": interface.network
                        })

    return instance_list

if __name__ == "__main__":
    project_id = "your-gcp-project-id"
    region = "us-central1"
    subnet_name = f"regions/{region}/subnetworks/your-subnet-name"

    instances = get_instances_in_subnet(project_id, region, subnet_name)
    if instances:
        print("Instances in the specified subnet:")
        for instance in instances:
            print(f" - {instance['name']} (Zone: {instance['zone']})")
    else:
        print("No instances found in the specified subnet.")
