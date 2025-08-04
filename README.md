Here’s a detailed Design Document for your IPAM Tool implementation, incorporating your updated tech stack and architecture.

⸻

🧾 IPAM Tool – Detailed Design Document

📌 Purpose

To manage, allocate, track, and visualize IP address usage for a given range across SDLC environments and GCP regions. This solution will help prevent subnetting conflicts, enable precise allocations, and support reporting and automation.

⸻

⚙️ 1. Technology Stack

Layer	Tool/Tech
Backend	Python (subnet logic, APIs)
Database	SQLite
Cloud Integration	gcloud CLI / REST APIs
Reporting	Python CLI or Web (Flask, Optional)
CSV Ops	pandas, csv modules


⸻

🗃️ 2. Master Table – master_ipam

Column	Type	Notes
cidr_range	TEXT (PK)	Unique subnet block (e.g., 100.124.0.0/24)
size	TEXT	Derived from CIDR (e.g., /24)
subnet_name	TEXT	Optional GCP subnet name
no_of_ips	INTEGER	Based on CIDR (e.g., /24 → 256)
region	TEXT	GCP region
sdlc	TEXT	SDLC (prod, nonprod, sandbox, etc.)
date	TEXT (ISO)	Allocation date
status	TEXT	One of: available, reserved, unavailable, planned


⸻

🔗 3. Architecture Overview

              +-------------------------+
              |      User Input (CLI)   |
              +-------------------------+
                         |
                         v
       +--------------------------+
       |  Python Subnet Logic     | ← uses ipaddress, netaddr libs
       +--------------------------+
            |          |
            |          v
            |    +------------+
            |    | SQLite DB  |
            |    +------------+
            |
            v
+------------------------------+
| Google Cloud API (gcloud CLI)|
| - Fetch IP range usage       |
| - Validate current allocation|
+------------------------------+


⸻

🧠 4. Implementation Modules

📌 A. Subnet Generator
	•	Inputs: CIDR block (e.g., 100.126.0.0/17), smallest subnet (e.g., /29), region, SDLC
	•	Generates: All subnets from /17 to /29 and inserts to master_ipam with:
	•	status = 'available'
	•	subnet_name = NULL, date = NULL

Key Libraries: ipaddress, sqlite3

⸻

📌 B. Reservation Logic
	•	Input: CIDR to reserve, subnet name
	•	Actions:
	•	Check in DB → ensure status = available
	•	Mark selected range as reserved
	•	Update all supernets and subnets as unavailable
	•	Log allocation date

Conflict Detection:
	•	If subnet or supernet is already reserved → error

⸻

📌 C. Reclamation Logic
	•	Input: CIDR to reclaim
	•	Actions:
	•	Mark CIDR as available
	•	If no overlapping sub/supernets are reserved, set them to available

⸻

📌 D. CSV Upload/Update
	•	Read CSV with columns: cidr_range, subnet_name, region, sdlc, status
	•	Validate against DB
	•	Bulk insert or update

Library: pandas or Python csv

⸻

📌 E. Google Cloud Integration
	•	Script uses gcloud compute networks subnets list or REST API
	•	Compares against local master_ipam
	•	Marks mismatches or confirms current usage

Goal:
	•	Track real-time GCP allocations
	•	Confirm if CIDR is truly in use

⸻

📊 5. Reporting Module

Summary Report CLI
	•	Query: Show available/reserved counts by CIDR size
	•	Output:

/24: 10 available
/25: 5 reserved
/29: 2 planned



Planned Report
	•	List all status = planned
	•	Option to reserve or reclaim

⸻

✅ 6. Example CLI Flow

$ python ipam.py generate --cidr 100.126.0.0/17 --min /29 --region us-central1 --sdlc prod

$ python ipam.py reserve --cidr 100.126.10.0/24 --name subnet-prod-1

$ python ipam.py reclaim --cidr 100.126.10.0/24

$ python ipam.py upload --csv updates.csv

$ python ipam.py report --filter prod --status available


⸻

🔍 7. Testing Strategy

Test Type	Tool	Description
Unit Testing	pytest	Subnet generation, overlap detection
CLI Testing	Bash	Simulate flows and check DB consistency
GCP Validation	gcloud	Compare local vs actual GCP usage
Data Consistency	SQL query	Validate DB entries post-reservation


⸻

Would you like:
	•	A Python CLI starter template?
	•	Sample test cases with mock data?
	•	A README structure to document usage?

Let me know how you want to proceed.
