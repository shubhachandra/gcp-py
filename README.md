Here’s a professionally written Requirement Document / Problem Statement based on your detailed input. You can format this into a Word document, Confluence page, or PDF as needed.

⸻

📘 Requirement Document – Intelligent IPAM System for Network Automation

📌 Project Title:

iPAM Automation with Network Admin API and Terraform Integration

⸻

📄 Problem Statement:

The network team typically allocates large CIDR blocks, such as 100.65.0.0/17, for use across environments and teams. However, there is no automated, structured mechanism to manage and allocate smaller subnets within this range across different use cases such as GKE, Composer, or other services.

Currently, subnet allocations and Terraform infrastructure provisioning require manual tracking and approvals. This introduces inefficiencies, potential for errors, and delays in project setup.

⸻

🎯 Objective:

To develop a semi-automated IP Address Management (iPAM) system using Excel + VBA + Terraform integration, which acts as:
	1.	A central database of all possible subnets derived from large CIDR blocks.
	2.	A user-facing interface for the Ops team to request subnet allocations.
	3.	An automation system that generates Terraform code, modifies tfvars files, raises Git PRs, and updates subnet statuses based on actions taken.

⸻

🧱 Functional Requirements:

1. Subnet Database Structure:

Upon receiving a large CIDR block (e.g., 100.65.0.0/17) from the network admin:
	•	The tool should break down this range into all possible CIDRs from /18 to /29.
	•	Each CIDR should populate a row in a database sheet with the following columns:
	•	Prefix Length (/18 to /29)
	•	CIDR Range
	•	Status – Initially set to Available
	•	SDLC – Pre-filled with options: Prod, Nonprod, Sandbox, Core
	•	Region – Options: us-central1, us-east1, us-east4, us-south1
	•	Usage Type – Routable, Non-Routable, PuPi, MasterIP

2. User UI Sheet for Subnet Requests:

The UI sheet allows users to:
	•	Select:
	•	T-Shirt Size (Micro-XS, Small-S, Medium, Large, Xtra-Large)
	•	Compute Type (GKE, Composer)
	•	Based on the selection, the system auto-selects the required CIDR blocks:

T-Size	Routable	PuPi	Non-Routable	Master IP (for GKE)
Micro-XS	/28	/23	/27	/28
Small-S	/27	/22	/26	/28
Medium	/26	/21	/25	/28
Large	/25	/20	/24	/28
Xtra-Large	/24	/19	/23	/28

	•	Based on availability in the database, the tool:
	•	Picks the required CIDRs
	•	Updates their status to Reserved
	•	Updates child and parent ranges to Unavailable to prevent overlap
	•	Displays selected ranges on the UI

3. Terraform Script Generation & Git Integration:

Once the IPs are selected:
	•	A Terraform subnet block is generated for each CIDR.
	•	The tool:
	•	Edits the *.tfvars or tfautovars.tf file with selected CIDRs.
	•	Creates a Git Pull Request (PR) to the Infra repo.
	•	Marks the PR for manual approval by the Networking team.

4. Post-Approval Automation:

Once the PR is merged and Terraform is applied:
	•	The tool:
	•	Updates the status of the CIDRs to Allocated
	•	Automatically updates the project provisioning repository
	•	Creates a confirmation PR reflecting the final IP assignments

⸻

🔁 IP Reservation Logic:
	•	When a CIDR block is reserved:
	•	Its status becomes Reserved
	•	Its child CIDRs are marked Unavailable
	•	Its parent CIDRs are marked Unavailable

⸻

📈 Benefits:
	•	Eliminates manual subnet allocation errors
	•	Reduces cycle time by automating GitOps processes
	•	Brings transparency and traceability to IP management
	•	Minimizes dependency on the Networking team for every request

⸻

📎 Future Enhancements:
	•	Integrate with Google Sheets or lightweight Web UI for broader usability
	•	API-based integration with Terraform Cloud or CI/CD tools
	•	Audit logs and conflict detection mechanisms

⸻

Let me know if you’d like this document exported in a specific format or tailored further for a stakeholder presentation.
