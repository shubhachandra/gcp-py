Got it ✅ — here’s only today’s text captured as Shubh’s update (nothing from earlier, just today’s content pulled together):

⸻

Shubh – Update (Sep 1, 2025)

Prod Discovery – Pending Actions
	•	Completed (Networking Team): Folder, Project, VPC, Subnet, Firewall.
	•	VPC-SC Creation → Owned by VPC-SC Team, ETA Sep 15. Includes:
	•	Prod Discovery VPC-SC separation.
	•	Implementation of env = prod discovery.
	•	Seed account creation.
	•	JIRA tickets updated by VPC-SC team.
	•	CI Environment → Ready and completed by Landing Zone Team.
	•	Requires upgrade to higher version of Folder Factory.
	•	Logging Project Creation → Owned by Landing Zone Team, still pending (dependencies exist).
	•	Seed Account Creation → Owned by Networking Team (PR + BLNC ticket shared).
	•	DNS + Service Enablement → Owned by Networking Team (PR + BLNC ticket details available).

⸻

Palo Alto
	•	Risk of missing alignment due to late-night meetings (1:30–2:00 AM IST).
	•	Difficult to follow the flow → working with Preetham on alternative learning strategy.
	•	Harsh created Palo Alto channel with weekly Friday meetings.
	•	Richard added me to this channel.
	•	Harsh defined expectations for leads vs PEs.
	•	Channel helps with active Q&A, documentation, and networking team readiness before app onboarding.

⸻

IPAM
	•	BlueCat Instance: Richard provided instance. Tried checking license, but he was unavailable last week.
	•	Plan to request SSL certificate via Venafi.
	•	Meeting with Host Connect Team (via Nigel) repeated known details.
	•	In-house IPAM Tool:
	•	REST API available, supports multi-tags.
	•	No Terraform integration.
	•	Not self-service → requires DDI engineer for environment setup with tags.
	•	BlueCat integration ETA: Dec 2025.

⸻

Cross-Team Support
	•	Spent significant time supporting other teams on:
	•	Project Factory changes & repo onboarding.
	•	Archetype identification.
	•	Fixing missing service agents, enabling active APIs.
	•	IAM issues.
	•	Troubleshooting Dataproc, Dataflow, Composer 3 instances.
	•	Utilization peak: 10:00 PM – 1:00 AM IST.

⸻

Perfect 👍 — here’s a single consolidated Weekly Update for your entire team with all members’ updates, pending actions, risks, and bandwidth captured.

⸻

Team Weekly Update – Week of Aug 18, 2025

⸻

Preetham
	•	Prod and Non-Prod separation completed.
	•	Ready for MACsec implementation in the coming week.

⸻

Sai
	•	Helping Hema with reclamation script enhancements.
	•	Coordinating with application teams for approvals.
	•	Handling intake requests, PR updates, and mail approvals in JIRA.
	•	Improved resource utilization compared to last two weeks.
	•	Working on TFE migration:
	•	Workspace in error state due to grantable role changes.
	•	Collaborating with Dele to fix.
	•	In process of enabling roles and stabilizing migration.

⸻

Hema
	•	Networking Diagram:
	•	Tried contacting Pavan, no response.
	•	Last iteration received “bit okay” feedback from Richard.
	•	Service Directory:
	•	Worked with Vijaya and team (Thu–Fri).
	•	Vijaya tested from her side.
	•	Provided solution for Senthil alerts.
	•	Educated PE team on Service Directory.
	•	Helped create Load Balancer and fixed observability issues.
	•	Requested access to repo → will work end-to-end deployment with PE.
	•	IPAM:
	•	On hold due to Service Directory focus.
	•	Reviewed Host Connect documentation.
	•	Subnet reclamation code handed to Sai.

⸻

Shubh
	•	Shared Subnet Work:
	•	Built shared subnets for Dataproc, Dataflow, Composer 3.
	•	Completed subnet creation, group binding, HNAT setup, and firewalls.
	•	Sandbox & Non-Prod done; customer confirmed successful usage.
	•	Prod CR today for onboarding customers using HNAT.
	•	Prod Discovery (Pending Actions):
	•	Completed (Networking Team): Folder, Project, VPC, Subnet, Firewall.
	•	VPC-SC Creation: Owned by VPC-SC team → ETA Sep 15 (workspace separation, env = Prod Discovery, seed account).
	•	CI Environment: Ready (Landing Zone team) but needs higher version of Folder Factory.
	•	Logging Project Creation: Owned by Landing Zone team → pending (dependencies remain).
	•	Seed Account Creation: Owned by Networking team (PR + BLNC ticket shared).
	•	DNS + Service Enablement: Owned by Networking team (PR + BLNC tickets in place).
	•	Palo Alto:
	•	Richard working in AD-Ent: created 3 workspaces, repo, VM project for testing.
	•	Tried replicating but Richard requested delay during CR window.
	•	Harsh created Palo Alto channel with Friday meetings (added by Richard).
	•	Harsh clarified expectations for leads vs PEs.
	•	Channel helps active discussions, Q&A, documentation readiness before onboarding apps.
	•	Late-night timings (1:30–2:00 AM IST) → hard to keep pace.
	•	Alternative learning strategy in progress with Preetham.
	•	Prisma Alerts:
	•	40 alerts in QA-Ent:
	•	12 → requested retain until Ashburn implementation (testing scripts).
	•	2 → redirected to IAM team.
	•	8 → to be suppressed (Cloud Build generated, not under control).
	•	IPAM SQL + notebooks under Richard → asked him to review.
	•	1 PSC alert mitigated successfully.
	•	Alerts on Richard’s roles → requested review.
	•	Ashburn 100G Connection:
	•	Coordinated with Preetham.
	•	Raised intake + CR.
	•	Scheduled Aug 26.
	•	IPAM Tool:
	•	Richard provided BlueCat instance. Tried checking license, but he was unavailable.
	•	Will request SSL cert via Venafi.
	•	Meeting with Host Connect (via Nigel) → repeated known info.
	•	In-house IPAM tool: REST API, supports multi-tags, but no Terraform. Needs DDI engineer setup.
	•	BlueCat integration ETA: Dec 2025.
	•	Cross-Team Support:
	•	Spent significant time assisting teams with:
	•	Project Factory changes, repo onboarding.
	•	Archetype identification, missing service agents.
	•	Active APIs, IAM issues.
	•	Dataproc, Dataflow, Composer 3 troubleshooting.
	•	Utilization peak: 10:00 PM – 1:00 AM IST.

⸻

Shubhachandra
	•	Third Region Deployment:
	•	Region setup completed → traffic routable to/from Ashburn.
	•	IP ranges allocated for us-east4 & us-south1 → whitelisted and working fine.
	•	VLAN Attachment & Bandwidth:
	•	Initially configured at <80 Gbps due to quota limits.
	•	Quota now reset to 200 Gbps for us-east4.
	•	Need to sync with Richard & SNI team to upgrade VLAN bandwidth.
	•	Risk: BGP flips if not upgraded.
	•	Suggestion: keep feature open and create a new RTD story for upgrade.

⸻

✅ This combined update shows:
	•	Each member’s deliverables.
	•	Pending actions with ownership & ETA.
	•	Risks (late-night Palo Alto, Prisma, quota bandwidth, dependencies).
	•	Cross-team dependencies and bandwidth strain.

Got it 👍 I’ll hold off finalizing until you share the remaining items you want to add.

Right now I have the weekly update draft for Shubhachandra like this:

⸻

Shubhachandra – Weekly Update
	•	Third Region Deployment
	•	Finished setup of the third region.
	•	Region is up and traffic is routable to and from Ashburn.
	•	IP ranges allocated for us-east4 and us-south1 have been whitelisted and are working fine.
	•	VLAN Attachment & Bandwidth
	•	VLAN attachment bandwidth initially configured at a lower end to stay within quota limits (<80 Gbps).
	•	Quota now reset to 200 Gbps for us-east4 region.
	•	Need to check with Richard along with SNI team to upgrade the VLAN attachment bandwidth.
	•	Risk: BGP flips possible at current config.
	•	Suggestion: Keep feature open and create a new story in RTD for the upgrade.

⸻

👉 Go ahead and drop the extra items you’d like to include, and I’ll extend this update neatly.

### ✅ Completed

* **Folder, Project, VPC & Subnet, Firewall** → **Networking Team**
* **CI Environment & Environment readiness** → **Landing Zone Team** (completed, but needs higher version of folder factory)

---

### ⏳ Pending Actions

1. **VPC SC Creation**

   * **Owner**: VPC SC Team
   * **ETA**: **Sep 15**
   * **Notes**: Jira details available; team is also separating **Prod Discovery workspace** for VPC SC ETA.

2. **Logging Project Creation**

   * **Owner**: Landing Zone Team
   * **ETA**: Pending (dependent on other tasks)
   * **Dependencies**: Networking-related setup.

3. **Seed Account Creation**

   * **Owner**: Networking Team
   * **ETA**: Pending
   * **References**: PR and BLNC ticket shared.

4. **DNS & Networking (Enabling Various Services)**

   * **Owner**: Networking Team
   * **ETA**: Pending
   * **References**: PR and BLNC ticket shared.

5. **Upgrade Folder Factory (Higher Version)**

   * **Owner**: Landing Zone Team
   * **ETA**: Pending (no date provided)
   * **Notes**: Required for CI/Environment readiness.

---

👉 Would you like me to prepare this as a **status tracker table** (Action | Owner | ETA | Status | Dependencies/Notes) so you can drop it directly into Confluence/Jira?
