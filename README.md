Here’s a clear and structured response that addresses each of your questions, tailored to your scenario involving routing updates in Google Cloud across SDLCs in the ad-ENT environment:

⸻

1. What are the benefits of implementing this change and impact if this change is not implemented?

Benefits:
	•	Ensures consistent routing behavior across all SDLCs (sandbox, nonprod, prod, and core).
	•	Enables core SDLC to function as a transit network, allowing traffic between other SDLCs.
	•	Prevents asymmetric routing and blackhole issues by keeping all routing tables in sync.
	•	Improves operational hygiene by removing outdated or inconsistent routes.
	•	Sets up a scalable and manageable routing structure across the environment.

Impact if not implemented:
	•	Risk of network segmentation, where environments may not reach each other due to stale or incorrect routes.
	•	Transit traffic via core may break, leading to outages or degraded service for dependent applications.
	•	Security and compliance issues from unintentional exposure or blocked traffic.
	•	Increased manual overhead to maintain workarounds for broken network paths.

⸻

2. What customer or client could be impacted in the blast radius if changes do not go as planned?
	•	Internal business applications relying on communication across SDLCs could break, especially services in sandbox/nonprod needing access to shared tools or core services.
	•	Critical production workloads that rely on backend services in the core may fail, potentially affecting external-facing customer systems.
	•	Shared services such as logging, monitoring, IAM proxies, or service accounts hosted in the core may become unreachable.
	•	Developer and QA teams may lose access to test or deploy if their VPCs become isolated.

Blast Radius Summary: High — due to the transit dependency on the core SDLC for all network traffic.

⸻

3. Describe post-change validation and checkpoint plan (CI is related to this change)?

Post-change validation plan:
	•	Automated health checks for each VPC to validate reachability to critical endpoints (e.g., DNS, GKE clusters, Bastion).
	•	Ping and trace route tests across SDLCs to validate routing flow (e.g., sandbox → core, nonprod → prod).
	•	Validate Cloud Interconnect (CI) or VPN BGP routes if used—ensure prefixes are advertised and accepted correctly.
	•	Confirm that all firewall rules and IAM bindings tied to network tags still allow intended traffic.

Checkpoints:
	•	Run Terraform plan & apply with -target to staged resources if needed.
	•	Snapshot and store pre-change routing tables for rollback reference.
	•	Run post-apply checks and document findings in a shared Change Management document.

⸻

4. Describe communication to business operations and Command Centre?
	•	Pre-change notification: Send communication 24-48 hours prior detailing:
	•	Change window
	•	SDLCs and services impacted
	•	Expected behavior and test plan
	•	Command Center Alert: Real-time update during the change via Slack/email, using a dedicated bridge or ticketing tool like ServiceNow/JIRA.
	•	Status updates: At key phases — Start, Mid-checkpoint, and Completion.
	•	Post-change summary: Include test results, rollback plan status, and links to logs/monitoring dashboards.

⸻

5. Why pre-testing is not possible?
	•	Core SDLC acts as a transit, and partial updates create incomplete or broken routing paths.
	•	Staggering changes across SDLCs can invalidate test results due to dependency on fully consistent routing across environments.
	•	Many systems (e.g., CI, shared logging, security controls) rely on inter-SDLC connectivity, which cannot be validated in isolation.
	•	QA-ENT testing already validated the logic; this environment is representative of the final configuration.

⸻

6. Risk Management Statement

While the routing changes are complex and impact multiple SDLCs, the change is necessary to ensure a stable and scalable network. Risks are mitigated through prior validation in QA-ENT, snapshotting current state, real-time monitoring, and a well-defined rollback plan. The team is prepared for coordinated, all-at-once deployment to maintain integrity of the core transit layer.

⸻

Let me know if you’d like this formatted as a change request template or Confluence page.

Thanks, Shubh. Based on the details you’ve provided, here’s a refined post-change validation checklist and supporting clarification around the specific /18 subnet entries — all focused on ensuring the SNI team verifies proper routing from on-prem to GCP.

⸻

✅ Post-Change Validation Checklist – SNI Team Responsibility

1. Health Check Ranges (GCP Load Balancers)

Verify the following IP ranges are routable from on-prem to GCP, especially from any appliance that monitors or terminates traffic (like firewalls or health probes):
	•	35.191.0.0/16 – GCP LB health checks (global)
	•	130.211.0.0/22 – GCP LB health checks (legacy)

Validation: Check firewalls, routers, and BGP routes to confirm these ranges are allowed and reachable from on-prem.

⸻

2. Core Routing Validation – GCP SDLC Transit

Core Ranges (Advertised)

Ensure reachability from on-prem to GCP core SDLC over the following /17 routes:
	•	100.126.128.0/17 – us-central1 core
	•	100.123.128.0/17 – us-east1 core

⸻

3. Sandbox Core Routing

Advertised Core Routes (Sandbox)

Ensure the following sandbox-specific cores are routed correctly from on-prem:
	•	100.126.0.0/17 – us-central1 sandbox
	•	100.123.0.0/17 – us-east1 sandbox

⸻

4. /18 Adjustments to Prevent Asymmetric Routing Issues (Trip Routing Fixes)

Due to the local-pref weight in on-prem routers, the /17 blocks are split into /18 subnets to ensure proper preference and route selection.

🔽 For us-east1 core (sandbox):
	•	100.123.0.0/18 – primary
	•	100.123.64.0/18 – companion split

🔽 For us-central1 core (sandbox):
	•	100.126.0.0/18 – primary
	•	100.128.64.0/18 – companion split

⸻

🔽 For us-east1 nonprod:
	•	100.125.0.0/18 – primary
	•	100.125.64.0/18 – split 1
	•	100.125.128.0/18 – split 2
	•	100.125.192.0/18 – split 3

🔽 For us-central1 nonprod:
	•	100.124.0.0/18 – primary
	•	100.124.64.0/18 – companion split

⸻

🔽 For us-central1 prod:
	•	100.124.128.0/18 – primary
	•	100.124.192.0/18 – companion split

⸻

🔽 For us-east1 prod:
	•	100.125.128.0/18 – primary
	•	100.125.192.0/18 – companion split

Validation Action:
Ensure all of these /18 subnets are correctly propagated and visible in:

	•	On-prem BGP route tables
	•	Cloud Router BGP sessions (on GCP)
	•	Any relevant NVA/VPN/Interconnect appliances

⸻

📌 Additional Notes for SNI Team
	•	These /18s are not arbitrary — they’re specifically used to influence route selection by breaking larger blocks to force preference via GCP vs. on-prem due to how Local Preference (local-pref) is being honored in BGP decisions.
	•	SNI should ensure only intended routes are preferred and symmetric return paths are maintained (no blackholes or misrouted return packets).

⸻

Would you like this in a Confluence-ready table format or a pre-filled email draft to share with the SNI team?

Sure, here’s a simpler and more concise version using plain language:

⸻

What customer or client could be impacted in the blast radius if changes do not go as planned?

If the routing changes do not go as planned, internal applications and teams that rely on communication between environments (like sandbox, nonprod, prod, and core) may face issues. For example:
	•	Applications in one environment may not be able to talk to shared services in the core.
	•	Teams may lose access to shared tools, monitoring systems, or CI/CD pipelines.
	•	Developers and testers might see delays or errors during deployments.

These issues can slow down day-to-day operations or affect how quickly problems are fixed.

⸻

Risk Mitigation Statement

This is a minor but important routing update. To reduce risk:
	•	We already tested the changes successfully in the QA environment.
	•	All changes are being applied together across environments to avoid partial issues.
	•	We have snapshots of current routes for rollback if needed.
	•	The network and SNI teams are ready to validate immediately after changes are made.

This helps ensure a smooth update with minimal impact.
