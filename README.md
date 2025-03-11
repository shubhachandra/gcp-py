import requests
session = requests.Session()
adapter = requests.adapters.HTTPAdapter(pool_connections=10, pool_maxsize=10, max_retries=5)
session.mount('https://', adapter)

response = session.get("https://your-api-url")
print(response.text)



Key Considerations for Subnet Design
IP Allocation Requirements: Each service needs a certain number of IP addresses.
Overlapping IP Ranges: Some services require separate IP blocks (e.g., Composer needs a dedicated range for GKE).
Private Google Access: Needed for all services to communicate with Google APIs without public IPs.
VPC Peering: If services are in separate subnets, VPC peering or Shared VPC is required.
Cloud NAT: If any service runs in a private network, Cloud NAT is required for internet-bound requests.
Possible Subnet Design Scenarios
Scenario 1: Single Primary Subnet for All Services
✅ When to Use:

If the combined IP requirements of all services fit within one large subnet.
If no separate private range is required for Composer or Dataproc clusters.
If services communicate within the same subnet without VPC Peering.
🔧 Recommended Subnet Setup:

pgsql
Copy
Edit
| Subnet Name | Region   | Primary CIDR Range | Purpose                                    |
|------------|---------|-------------------|--------------------------------------------|
| main-subnet | us-central1 | 10.10.0.0/16       | Shared subnet for Composer, Dataproc, Dataflow, Vertex AI |
Pros:

Simple networking with all services in a single subnet.
No need for VPC Peering.
Easier to manage firewall rules.
Cons:

Risk of IP exhaustion due to all services using the same range.
Composer might require a secondary range for GKE pods.
Can create network congestion if services scale aggressively.
Scenario 2: Separate Subnets for Each Service
✅ When to Use:

If each service needs dedicated IPs for better isolation.
If Cloud Composer (GKE) and Dataproc clusters need separate private ranges.
If network segmentation and better security policies are required.
🔧 Recommended Subnet Setup:

pgsql
Copy
Edit
| Subnet Name       | Region       | Primary CIDR Range | Purpose                      |
|------------------|-------------|-------------------|------------------------------|
| composer-subnet  | us-central1 | 10.10.0.0/24      | Dedicated for Cloud Composer |
| dataproc-subnet  | us-central1 | 10.10.1.0/20      | Dedicated for Dataproc clusters |
| dataflow-subnet  | us-central1 | 10.10.2.0/24      | Dedicated for Dataflow workers |
| vertex-subnet    | us-central1 | 10.10.3.0/24      | Dedicated for Vertex AI Workbench |
Pros:

Better IP allocation control and security segmentation.
Composer and Dataproc clusters get dedicated private IP ranges.
No risk of IP exhaustion from multiple services.
Cons:

Requires VPC Peering or shared services firewall rules for internal communication.
More complex firewall rule management.
Scenario 3: Hybrid Approach (Primary Subnet + Secondary Ranges)
✅ When to Use:

If a single subnet is preferred, but Composer and Dataproc require separate secondary ranges.
Efficient use of IP addresses while ensuring Composer GKE and Dataproc nodes have their own private ranges.
🔧 Recommended Subnet Setup:

pgsql
Copy
Edit
| Subnet Name  | Region      | Primary CIDR Range | Secondary CIDR Ranges          | Purpose                      |
|-------------|------------|-------------------|--------------------------------|------------------------------|
| main-subnet | us-central1 | 10.10.0.0/16      | 10.10.100.0/24 (Composer GKE)  | Shared subnet for all services with secondary IPs |
|             |            |                   | 10.10.101.0/24 (Dataproc VMs)  |                              |
Pros:

Simplifies networking while keeping services in a single VPC.
Avoids unnecessary VPC Peering.
Efficient use of IP space by leveraging secondary ranges.
Cons:

Still requires subnet-level firewall rules for better traffic management.
If Composer or Dataproc scales significantly, secondary IPs may be insufficient.
Final Recommendation
Scenario	Recommended For	Complexity	IP Efficiency	Security Isolation
Scenario 1 (Single Primary Subnet)	Small-scale deployments, easy management	Low	High risk of exhaustion	Low
Scenario 2 (Separate Subnets)	High-scale production environments	High	Best allocation	Best isolation
Scenario 3 (Hybrid Approach)	Balanced approach for mid-size workloads	Medium	Good allocation	Moderate isolation
👉 Best Approach: Scenario 3 (Hybrid)

Single primary subnet with secondary ranges for Composer GKE and Dataproc.
Ensures optimal resource allocation while keeping networking simple.
Easy to scale without redesigning VPC architecture.
