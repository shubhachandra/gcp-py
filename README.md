Here’s a **Google Sheet–friendly tracking template** you can use to manage and track the daily progress of your GCP subnet reclamation initiative.

---

### 🧾 **GCP Subnet Reclamation Tracker – Daily Update Template**

| Date       | Subnets Identified | App Teams Contacted | Teams Responded | Teams Approved | PRs Created | Intake Requests Raised | Subnets Reclaimed | Sheet Updated (Yes/No) | Subnets Proposed for Prod | Notes / Blockers        |
| ---------- | ------------------ | ------------------- | --------------- | -------------- | ----------- | ---------------------- | ----------------- | ---------------------- | ------------------------- | ----------------------- |
| YYYY-MM-DD | 12                 | 5                   | 3               | 2              | 4           | 4                      | 3                 | Yes                    | 1                         | Waiting for 2 sign-offs |
| YYYY-MM-DD |                    |                     |                 |                |             |                        |                   |                        |                           |                         |

---

### 💡 Column Descriptions

* **Date** – Entry date of the activity
* **Subnets Identified** – Count of unused subnets flagged from report
* **App Teams Contacted** – Count of unique app teams reached out to
* **Teams Responded** – Teams that replied (acknowledged)
* **Teams Approved** – Teams that explicitly approved subnet deletion
* **PRs Created** – Count of PRs raised for networking/provisioning repos
* **Intake Requests Raised** – Related intake requests initiated
* **Subnets Reclaimed** – Count of subnets officially deleted from Terraform
* **Sheet Updated** – Whether tracking sheet (IP sheet, internal list) was updated post deletion
* **Subnets Proposed for Prod** – Number of prod subnets eligible for reclaim (after team approval)
* **Notes / Blockers** – Any dependencies, delays, or clarifications

---

### Optional Enhancements:

* Add **drop-downs** for "Sheet Updated" (Yes/No)
* Use **conditional formatting** to highlight pending approvals
* Add a separate tab for **team-wise status**

---

Perfect. Here's the **cleaned-up version** of your **Subnet Reclamation Tracker template**, with **Yes/No columns removed** where direct values like Jira ticket numbers, PR IDs, or dates will be captured instead.

---

### 🧾 GCP Subnet Reclamation Tracker – Clean Version (No Redundant Yes/No Fields)

| Subnet Name | IP Range    | SDLC    | App ID | Subnet Identified Date | Link Legends Jira Ticket | App Team Communication Date | App Team Acknowledged | App Team Approval Status (Approved / Denied with Justification) | Has Prod Subnet (Y/N) | Prod Communication Date | PR ID / Link | Intake Request Jira | PR Updated in Jira (Y/N) | CR Scheduled Date | Reclaimed Date | Time Taken (HH\:MM) | Notes / Blockers       |
| ----------- | ----------- | ------- | ------ | ---------------------- | ------------------------ | --------------------------- | --------------------- | --------------------------------------------------------------- | --------------------- | ----------------------- | ------------ | ------------------- | ------------------------ | ----------------- | -------------- | ------------------- | ---------------------- |
| subnet-01   | 10.1.2.0/24 | sandbox | fndd   | 2025-07-10             | LINK-1234                | 2025-07-11                  | Yes                   | Approved                                                        | No                    | N/A                     | PR-4567      | INTK-8910           | Yes                      | 2025-07-20        | 2025-07-21     | 02:15               | Completed              |
| subnet-02   | 10.2.3.0/24 | nonprod | fndd   | 2025-07-10             | LINK-1235                | 2025-07-11                  | Yes                   | Denied – Used for backup testing                                | Yes                   | 2025-07-12              | PR-4578      | INTK-8911           | Yes                      | 2025-07-22        | Pending        | --                  | Awaiting prod sign-off |

---

### 📌 Column Descriptions

| Column                                     | Description                                                |
| ------------------------------------------ | ---------------------------------------------------------- |
| **Subnet Name / IP Range / SDLC / App ID** | Basic subnet metadata                                      |
| **Subnet Identified Date**                 | When the subnet was flagged as reclaimable                 |
| **Link Legends Jira Ticket**               | Jira ticket raised for tracking deletion effort (per SDLC) |
| **App Team Communication Date**            | When the subnet reclaim email was sent to app team         |
| **App Team Acknowledged**                  | Whether the app team responded                             |
| **App Team Approval Status**               | Result of communication: Approved or Denied with reasoning |
| **Has Prod Subnet**                        | If app has associated prod subnets to process later        |
| **Prod Communication Date**                | When prod subnet communication was sent (if applicable)    |
| **PR ID / Link**                           | PR created in networking or provisioning repo              |
| **Intake Request Jira**                    | Intake ticket ID for tracking infra change                 |
| **PR Updated in Jira**                     | Whether PR ID has been added to Jira                       |
| **CR Scheduled Date**                      | Date when CR is scheduled                                  |
| **Reclaimed Date**                         | When the subnet was officially deleted                     |
| **Time Taken (HH\:MM)**                    | Approximate time spent end-to-end                          |
| **Notes / Blockers**                       | Comments or special cases                                  |

---

Would you like me to deliver this in **Excel (.xlsx)** or **Google Sheets format** with built-in filters and formatting? Just say the word and I’ll generate it!



