Here's a **cleaned-up version of your content as clear, concise presentation bullet points**, while preserving all key technical details:

---

### 🔧 Issue Faced in GCP

* Encountered a **400 error** due to exceeding the **1,500 IAM policy bindings limit** in GCP.
* Cause: Every time a new project was added, the **Active Service Account (Service Agent)** was granted the `compute.networkUser` role on **shared VPC subnets**.
* This led to an increasing number of service accounts being added to shared subnet IAM policies, ultimately hitting the limit.

---

### 🛠️ Collaboration & Fix

* Engaged with **Google Support**, who advised using **Google Groups** instead of assigning roles to **individual service accounts**.
* Worked with the **Landing Zone (LZ)** and **IAM teams** to:

  * Create appropriate **Google Groups**.
  * Update **group IDs** in the project factor code.
* **Richard** assisted in coding changes to add **service agents to the group** instead of assigning roles individually.

---

### 🚀 Fix Implementation

* Updated the **project factory code**.
* **LZ team released version 4.2.1**, which initially resolved the issue in spoke projects.

---

### 🪲 New Bug in Host Project

* The **same 400 error occurred in the host project** after the 4.2.1 release.
* Based on Richard's recommendation:

  * Introduced a **flag** to **skip assigning roles to the service agent** at the **host project** level.
  * Released an updated version **4.2.2** to fix this issue.

---

### 🤝 Final Steps & Resolution

* **Ops team had already migrated to version 4.2.1**, which still had the host project bug.
* We coordinated with the Ops team to:

  * **Explain the issue** and how the role assignment logic had changed.
  * Push an **immediate upgrade to version 4.2.2**, resolving the problem in host projects.

---

Let me know if you'd like this in slide-ready format (e.g. PowerPoint, Google Slides) or with visual aids like a flow diagram of the fix.
