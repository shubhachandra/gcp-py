Sharing this document where we can capture evidence of routing learned by on-prem as we gradually publish routes from our different SDLC environments (core, nonprod, prod, sandbox).

Rather than treating it as a template, think of it as a working document to drop in:

Screenshots or CLI outputs showing which prefixes were learned on-prem after each GCP publish

BGP session status (to confirm peering is up)

Any observations or anomalies (like route delay or partial learning)

We can use this to track progress SDLC-wise and region-wise, and ensure nothing gets missed during the staggered rollout. Feel free to add sections or adapt it as needed.

Let me know if you face any issues accessing or editing it.
- SDLC Published: core / nonprod / prod / sandbox
- Region: us-central1 / us-east1
- GCP VPC Range Published: 10.X.0.0/18
- Date of Publish: YYYY-MM-DD
- Publishing Type: BGP dynamic advertisement via Cloud Router
- Cloud Router: cloud-router-<sdlc>-<region>
- Peer GCP ASN: 64512 (example)
- Peer On-prem ASN: 65000 (example)

2. On-Prem Route Learn Verification
Run appropriate BGP command on your on-prem router (e.g., Cisco, Juniper, FortiGate):

- Cisco: show ip bgp | include 10.X.0.0
- Juniper: show route receive-protocol bgp
- FortiGate: get router info bgp network

Sample Log Output:

* 10.50.0.0/18   35.XX.XX.XX             0 64512  i
* 10.51.0.0/18   35.XX.XX.XX             0 64512  i

Route Learned	Next Hop	Source ASN	Status
10.50.0.0/18	35.x.x.x	64512 (GCP)	Valid
3. BGP Session Health Check

Use the following commands to check BGP session status on-prem:
- Cisco: show ip bgp summary
- Juniper: show bgp summary
- FortiGate: get router info bgp summary

Sample Output Table:
Peer IP	ASN	State	Uptime	Routes Received
35.x.x.x	64512	Established	00:15:23	2
4. Comments / Observations

- Are expected routes present?
- Any route filtering applied?
- Any duplicate or missing entries?
Example:
> Successfully received routes from core-us-central1. Next SDLC nonprod-us-central1 to be published on 2025-06-21.

5. Final Checklist (Per SDLC-Region)
Validation Step	Status	Notes
GCP routes advertised	✅ / ❌	
BGP session up	✅ / ❌	
Expected prefixes learned	✅ / ❌	
Screenshots/logs saved	✅ / ❌	
6. Suggested Folder Structure

onprem-routing-learn/
├── core-us-central1/
│   ├── bgp-summary.txt
│   ├── learned-routes.txt
│   ├── screenshots/
│   └── validation.md
├── core-us-east1/
├── nonprod-us-central1/
...

