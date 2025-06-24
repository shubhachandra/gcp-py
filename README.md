Here's a **professional and clear email draft** you can send to the **Ops team** about the proposed **Subnet Reclamation Process**, highlighting roles, communication flow, and expectations.

---

### **Subject:** Proposal for Subnet Reclamation Process – Ops Team Collaboration Required

---

Hi Team,

We’re proposing a **structured subnet reclamation process** to optimize IP utilization and ensure hygiene across SDLC environments. This effort will require **close collaboration between the Ops team and the Networking team**, and your support will be critical in executing this initiative smoothly.

---

### 📌 **Objective**

Identify and reclaim subnets that have been **idle for more than 90 days**, based on daily reports generated from Grafana. These subnets often remain unused after initial provisioning, resulting in IP fragmentation and unnecessary allocation.

---

### 🤝 **Roles & Communication Flow**

#### **1. Report Analysis (Network Team)**

* The **network team** will review the daily Grafana report and **shortlist candidate subnets** that appear unused.
* These will be shared with the **Ops team**, along with the associated project and environment details.

#### **2. App Team Coordination (Ops Team)**

* The **Ops team will help contact the respective application owners** to validate the subnet usage.
* This outreach will include:

  * Subnet name, region, and project ID
  * Request for confirmation on whether the subnet is still in use
  * A **response SLA of 5 business days**

#### **3. No Response Policy**

* If no response is received within the SLA, and there is **no known dependency** on the subnet, it will be considered **safe for auto-deletion** following a final reminder.

#### **4. Intake and Deletion**

* Upon confirmation from the app team or after SLA expiry:

  * The **Ops team** will raise an **intake request** for subnet deletion.
  * The **Network team** will validate and coordinate PR changes via Terraform to delete the subnet.

---

### ✅ **Benefits of the Process**

* Improved IP space management and availability
* Clean and minimal subnet usage across SDLC
* Reduced provisioning delays for new GKE, Composer, and notebook workloads

---

### 🔄 **Next Steps**

We’d like to **align with Ops on the following**:

1. Confirm support for application team outreach
2. Define the **communication format** (email/slack/intake ticket) to app teams
3. Agree on the **SLA policy and auto-deletion procedure**

Please let us know if we can set up a short sync to walk through this or finalize via email. Your partnership is key to making this successful and scalable.

Best regards,
**\[Your Name]**
Network Engineering Team
\[Optional: Attach flowchart or reference doc]

---

Let me know if you want to customize this by adding an attachment, or if you're writing on behalf of a team or manager.
