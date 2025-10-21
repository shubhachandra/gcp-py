Here’s a summarized email draft you can send 👇

⸻

Subject: BigQuery Access from On-Premises – Connectivity Modes and IP Whitelisting

Hi [Team/Network/Security Team],

Please find below the summary of available connectivity options for enabling communication between our on-premises applications and BigQuery, along with IP ranges for whitelisting.

⸻

Connectivity Modes
	1.	Public Internet Access
	•	Access BigQuery APIs over the public internet via HTTPS (bigquery.googleapis.com).
	•	No fixed IP list available — Google uses dynamic ranges.
	•	Recommended to allow outbound to *.googleapis.com over port 443 instead of IP-based whitelisting.
	2.	Private Connectivity via VPN / Interconnect + Private Google Access (PGA)
	•	Provides private communication over existing VPN or Interconnect.
	•	Enable Private Google Access or Restricted Google Access on the VPC subnet.
	•	Whitelist IP ranges:
	•	199.36.153.4/30 (Restricted Google Access)
	•	199.36.153.8/30 (Private Google Access)
	•	34.126.0.0/18 (Additional Google API range)
	•	IPv6 equivalents: 2600:2d00:0002:1000::/64, 2600:2d00:0002:2000::/64, 2001:4860:8040::/42
	•	Recommended for secure enterprise connectivity.
	3.	Private Service Connect (PSC) to Google APIs
	•	Creates a private endpoint in GCP for Google APIs (including BigQuery).
	•	On-prem traffic routes via VPN/Interconnect to the VPC, then through PSC to Google.
	•	Whitelisting is required only up to the VPC endpoint; traffic beyond that remains internal to Google’s network.
	•	Uses the same underlying IP ranges as Private Google Access.

⸻

Key Notes
	•	All BigQuery access should use IAM-based authentication (service accounts or OAuth).
	•	Whitelisting IPs for public internet mode is not reliable due to dynamic address changes.
	•	Prefer Private Google Access or PSC for stable, secure connectivity.
	•	All traffic uses HTTPS (port 443).
	•	Periodically review Google’s published IP ranges for updates.

⸻

Recommended Approach:
Use Private Google Access or PSC through existing VPN/Interconnect links for secure, compliant, and stable BigQuery connectivity.

Best regards,
[Your Name]
[Your Role / Team]

⸻

Would you like me to tailor this mail for your network/security team (formal version) or internal project documentation (slightly more technical version)?
