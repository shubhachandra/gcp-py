Here are the **Minutes of Meeting (MoM)** based on your notes:

---

### **Minutes of Meeting**

**Date:** \[Insert Date]
**Subject:** VRF Segmentation & Network Design Alignment – GCP & On-Prem Sandbox Environments
**Attendees:** \[List of attendees if known]
**Prepared by:** \[Your Name]

---

### **Discussion Points:**

1. **Current Environment:**

   * GCP has a separate **sandbox**.
   * On-prem also maintains a **sandbox** environment.
   * Currently, **non-prod** and **sandbox** are being grouped under a **single VRF**, which is part of the existing design.

2. **Desired State:**

   * Proposal to **split VRFs** for **non-prod** and **sandbox** to ensure **network segmentation** and **better traffic isolation**.
   * This separation is **not part of the current approved design**.
   * There are **4 existing VRF segments**:

     * AD-ENT PROD
     * AD-ENT NONPROD
     * QA-ENT PROD
     * QA-ENT NONPROD
   * The above segmentation approach is consistent with the **Azure** environment as well.

3. **Capacity and Planning:**

   * All **non-prod VRFs** will be configured with **10 Gbps links**.
   * **Production VRFs** will have higher throughput (exact bandwidth not specified).
   * The team noticed **non-prod and sandbox** are currently able to talk to each other, which prompted this discovery and re-evaluation.

4. **Impact on Timelines:**

   * Creating new, **separate VRFs for sandbox** will impact the timeline and extend it by **a few more weeks**.
   * As of now:

     * **AD-ENT** has 3 VRFs.
     * **QA-ENT** has 3 VRFs.
     * Discussion is ongoing if adding an **additional (fourth) VRF** later is acceptable from a design and operations standpoint.

5. **Action Items & Coordination:**

   * **Preetham** to collaborate with **Ops team** to initiate necessary **Change Requests (CRs)**.
   * **Ashburn** and **Chicago** environments are fully up, with **all four links live** on both GCP and On-prem sides.
   * For **Dallas**, coordination is needed with **Carol** to proceed further.
   * Domain updates and communication of **target dates to SNS** teams are pending.
   * There's a requirement to **shut down BGP on the production VRF** – timing and steps to be confirmed.

---

### **Decisions Made:**

* Agreement that **separate VRFs for sandbox and non-prod** are required for future scalability and isolation, though it's not in the current design.
* Proceed with evaluating **impact of adding new VRFs** and how it affects timelines.

---

### **Next Steps / Action Items:**

| **Task**                                                    | **Owner**                      | **Due Date**   |
| ----------------------------------------------------------- | ------------------------------ | -------------- |
| Coordinate CR submissions for VRF changes                   | Preetham                       | \[Insert Date] |
| Collaborate with Carol for Dallas readiness                 | \[Your Name / Team]            | \[Insert Date] |
| Share domain updates and VRF activation dates with SNS team | \[Your Name / Networking Team] | \[Insert Date] |
| Plan and execute BGP shutdown for PROD                      | Network Team                   | \[Insert Date] |

---

Let me know if you'd like a polished PDF version or email template based on this MoM.
