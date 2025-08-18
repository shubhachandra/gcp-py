Got it 👍 — I’ll capture the **team’s week update** with all the details you’ve shared, keeping Preetham and Sai’s as-is, and updating Hema’s and Shubh’s parts properly.

---

# **Team Weekly Update – Week of Aug 18, 2025**

---

### **Preetham**

* Update remains the same.
* **Prod and Non-Prod separation** has been completed.
* We are ready for **MACsec implementation** in the coming week.

---

### **Sai**

* Helping **Hema** in enhancing the **reclamation scripts**.
* Communicating with **application teams** for approval.
* Opening **intake requests**.
* Updating **PRs** and capturing **mail approvals** in JIRA.
* Improved **utilization** compared to the last two weeks.
* Working on **TFE migration**:

  * Workspace is in **error state** due to change in **grantable roles**.
  * Collaborating with **Dele** to fix.
  * Enabling roles and progressing towards a **stable migration state**.

---

### **Hema**

* **Networking Diagram**:

  * Tried reaching out to **Pavan**, no response received.
  * Last iteration received feedback from **Richard** – “bit okay”.
* **Service Directory**:

  * Working with **Vijaya and team** (Thu–Fri).
  * **Vijaya tested** from her side.
  * Provided a solution for **Senthil alerts**.
  * Later, **PE team communicated** and Hema educated them on **Service Directory usage**.
  * Helped create a **Load Balancer**.
  * Fixed **observability issues**.
  * Requested access to their **repo** to work on **end-to-end deployment**.
* **IPAM**:

  * Put on **hold** due to Service Directory priorities.
  * Reviewed **documentation on Host Connect**.
  * **Subnet reclamation code handed over to Sai**.

---

### **Shubh**

* **Shared Subnet Work**:

  * Created shared subnets for **Dataproc, Dataflow, Composer3**.
  * Completed **subnet creation, group binding, Hybrid NAT setup, and firewall rules**.
  * **Sandbox and Non-Prod** completed last week, with **customer confirmation** on successful usage.
  * **Prod CR scheduled today**, onboarding customers using **HNAT**.

* **Prod Discovery**:

  * Taking a **backseat** while awaiting **VPC-SC team & Landing Zone team**.
  * Updated **JIRA tickets** with VPC-SC dependencies.
  * Teams working on **Prod Discovery VPC-SC separation**, **environment = Prod Discovery**, and **seed account creation**.
  * ETA: **End of August for QA**, **Sep 15 for AD-Ent** (may slip to **end of September**).

* **Palo Alto Implementation**:

  * **Richard** working in **AD-Ent**:

    * Created **3 workspaces, repo, and VM project**.
    * Testing implementation.
  * Tried to **replicate in AD-Ent**, but during **CR window**, Richard requested to **delay by a week**.

* **Prisma Alerts**:

  * Actively working with Prisma team.
  * **40 alerts in QA-Ent**:

    * 12 requests raised to **retain till Ashburn implementation** (scripts under testing).
    * 2 redirected to **IAM team**.
    * 8 to be **suppressed** (not under control, created by Cloud Build).
    * **IPAM SQL instance & some notebook instances** are under **Richard’s control** → asked him to check.
    * **1 PSC alert** mitigated successfully.
    * Alerts also on **Richard’s roles** → requested him to review.

* **Ashburn 100G Connection**:

  * Coordinated with **Preetham**.
  * Raised **intake request & CR** for changes.
  * **Scheduled on 26th Aug**.

---
Perfect — I’ll add that new **Palo Alto channel/coordination update** under your section. Here’s the refined capture for **Shubh** with the new details included:

---

### **Shubh**

* **Shared Subnet Work**:

  * Created shared subnets for **Dataproc, Dataflow, Composer3**.
  * Completed **subnet creation, group binding, Hybrid NAT setup, and firewall rules**.
  * **Sandbox and Non-Prod** completed last week, with **customer confirmation** on successful usage.
  * **Prod CR scheduled today**, onboarding customers using **HNAT**.

* **Prod Discovery**:

  * Taking a **backseat** while awaiting **VPC-SC team & Landing Zone team**.
  * Updated **JIRA tickets** with VPC-SC dependencies.
  * Teams working on **Prod Discovery VPC-SC separation**, **environment = Prod Discovery**, and **seed account creation**.
  * ETA: **End of August for QA**, **Sep 15 for AD-Ent** (may slip to **end of September**).

* **Palo Alto Implementation**:

  * **Richard** working in **AD-Ent**:

    * Created **3 workspaces, repo, and VM project**.
    * Testing implementation.
  * Tried to **replicate in AD-Ent**, but during **CR window**, Richard requested to **delay by a week**.
  * **Harsh created a dedicated Palo Alto channel** with **weekly Friday meetings**.

    * Richard added me to the same.
    * In the session, Harsh defined **expectations for leads vs. PEs**.
    * This channel helps keep everyone **active in discussions**, **asking questions**, and **understanding implementations**.
    * It also ensures **documentation readiness** from the networking team before **application onboarding**.

* **Prisma Alerts**:

  * Actively working with Prisma team.
  * **40 alerts in QA-Ent**:

    * 12 requests raised to **retain till Ashburn implementation** (scripts under testing).
    * 2 redirected to **IAM team**.
    * 8 to be **suppressed** (not under control, created by Cloud Build).
    * **IPAM SQL instance & some notebook instances** are under **Richard’s control** → asked him to check.
    * **1 PSC alert** mitigated successfully.
    * Alerts also on **Richard’s roles** → requested him to review.

* **Ashburn 100G Connection**:

  * Coordinated with **Preetham**.
  * Raised **intake request & CR** for changes.
  * **Scheduled on 26th Aug**.

---

Would you like me to now **combine Preetham, Sai, Hema, and Shubh into one clean weekly status report (ready-to-send)**, or keep them as individual updates for your tracking?

✅ This way, each member’s contribution is clearly tracked with dependencies, blockers, and progress.

Do you want me to **merge this into a single email draft** (to send as weekly status) or keep it in this structured note format?
