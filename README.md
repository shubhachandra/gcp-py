Got it. Here’s an updated clarification added to your IPAM tool design:

⸻

🔁 Subnet Allocation Process (Detailed Workflow)
	1.	Trigger: User requests allocation of a subnet (via CLI/UI).
	2.	Validation via GCP:
	•	Script uses gcloud API to query existing subnets in GCP.
	•	Checks if the requested CIDR already exists.
	•	If found in GCP: mark as reserved in DB (if not already).
	•	If not found: mark as available (if DB says otherwise, raise conflict).
	3.	Master Range Logic:
	•	All IP generation (e.g., /29 subnets within a /17) is based on predefined master CIDR blocks, hardcoded within the Python code.
	•	Only subnets falling within these master ranges are eligible for creation/reservation.

Let me know if you’d like the updated allocation logic documented in pseudocode or flowchart.
