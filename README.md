Here’s the updated Jira ticket content with clearly defined Acceptance Criteria:

⸻

Title: Decommission Unused Test Subnets and Provision New Shared Subnets for Region Expansion

⸻

Description:

This ticket includes two major actions:

⸻

1. Deletion of Unused Test Subnets

Subnets to Delete:
	•	test-subnet-usc1-100-126-100-0-24
	•	(Add other subnet names if applicable)

Justification:
	•	Originally created for testing purposes; no longer required.
	•	Network Analyzer confirms only 8% usage:
	•	1 Reserved IP (not assigned)
	•	1 Internet Gateway IP
	•	1 Broadcast IP
	•	1 Network IP
	•	No GCP services or workloads actively use these subnets.

Evidence:
	•	Screenshot from Network Analyzer confirming unused status (attached).

⸻

2. Creation of Shared Subnets in us-south1 and us-east4

Purpose:
To support regional expansion by enabling GCP managed services access via private IPs in:
	•	us-south1
	•	us-east4

Subnet Details:

Region	Subnet Name	CIDR Range	Description
us-south1	nonprod-netb-ainotebook-uss1-100-126-144-0-25	100.126.144.0/25	Shared subnet for GCP managed services
us-east4	nonprod-netb-ainotebook-use4-100-126-200-0-25	100.126.200.0/25	Shared subnet for GCP managed services

	•	Subnets will be shared via Shared VPC.
	•	Private DNS A-records will be created to resolve managed services (Vertex AI, Dataflow, Dataproc) internally.

⸻

Acceptance Criteria:
	1.	For Subnet Deletion:
	•	Subnet(s) are deleted successfully.
	•	No IAM bindings or active dependencies exist on the deleted subnet.
	•	Network Analyzer screenshot showing 8% usage is attached as evidence.
	•	IP range reclaimed and marked as available in IPAM documentation.
	2.	For Subnet Creation (Region Expansion):
	•	Shared subnets are created in us-south1 and us-east4 with correct CIDR ranges.
	•	Private Google Access is enabled on the subnets.
	•	DNS A-records for GCP services (e.g., vertexai.googleapis.com) are created and resolve internally.
	•	Subnets are shared successfully with appropriate service projects.
	•	Verification of internal access to GCP managed services using private IPs is successful.
	3.	Documentation:
	•	All changes are reflected in the central network documentation or IP inventory.
	•	Terraform code (if used) is updated and committed.

⸻

Let me know if you’d like a subtasks breakdown or Terraform module snippets for subnet and DNS creation.
