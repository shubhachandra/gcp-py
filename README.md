Here’s a **clearer and more professional** version of your sentence, organized by individual, with improved grammar, structure, and clarity. I’ve also preserved all the original technical details:

---

### **Work Items by Individual**

---

#### **Shubh**

* Currently working on **building the third region** (sandbox); non-prod is already coded.
* The **Change Request (CR)** has been implemented and assigned to **Hema** and **Sai**.
* **Production implementation** is **pending**, scheduled for **this Wednesday**.
* **PSC subnet cleanup** (for unused subnets):

  * Completed for **sandbox** and **non-prod**.
  * **Production CR implementation is pending**.
* Regarding **Bluenat**:

  * After discussions with **Lakshmi**, **Indu**, and the **IAM Ops team**, we found that **only Richard** has the `compute.admin` role.
  * IAM Ops cannot assign `compute.engine` role to others.
  * Richard currently lacks the bandwidth to create the instance with the license.
* I have created an **Excel sheet with VBA** for **IPAM management**. It's working; needs finalization. I can demonstrate the working version.
* On **NIC**:

  * Collaborated with the **Grafana team**; dashboard looks good.
  * Communicated the need for APIs to identify unused subnet NAT ranges and **request deletions automatically**.
  * **Venkat** confirmed this is possible.
* For **Production discovery (pdisco)**:

  * Coordinated with the **Landing Zone (LZ) team** to create a new `ci.environment` value `pdisco` and include it in validations.
  * **Sudhakar** informed that this must come from the **configuration team / ServiceNow** — follow-up required.
* Due to the above dependencies, my ticket is **currently blocked**.
* On **Error 400**:

  * Reached out to the **border team** and raised a **P1 ticket with Google**.
  * Google has **increased the limit from 1500 to 2500** – this is a **tactical fix**.
  * For a **strategic solution**, we’ll follow **Richard’s recommendation**.
* Requested **group creation** for:

  * **Serverless VPC access**
  * **Composer host VPC agent**
  * **Kubernetes host VPC agent**
* Code is ready to assign roles to these groups.
* Still need to **add service agents** to the groups — awaiting group creation (possibly delayed due to a US holiday).
* **LZ team is in sync** with us on these changes.

---

#### **Hema**

* Working on the **network topology diagram** — requires significant modification from the original.
* Regular sync-up sessions are ongoing.
* Working on **automating the subnet reclaiming process** using **Cloud Scheduler**.

  * Awaiting **Grafana board APIs**.
* Also deploying the **Model Armor API** on **private regional endpoints**.

  * This API helps **protect datasets used by ML/AI teams**.
  * Deployment targets **new additional regions**.

---

#### **Preetham**

* **ISBL for Hybrid NAT** is in the **final stage** — regulation policy to be completed this sprint.
* **MSAC end-to-end testing** is in progress:

  * **Richard** needs to provide **MSAC keys**.
  * There's limited **Terraform support** for MSAC.
  * Working with **Google** on an **alternative approach via a support case**.
  * Plan to use the **console temporarily**, pending confirmation from Google.
* Also working on **activating the 10 Gbps Chicago link**, which is currently **not coming up**.

---

#### **Sai**

* Started work on **delegated DNS**:

  * Made necessary code changes.
  * Needs to **push the PR** and **get it approved**.
* Working on **migrating workloads** from **TFE non-prod to TFE prod**:

  * Collaborating with **Sudhakar**.
  * Connection scheduled for **tonight** to continue work.

---

Let me know if you'd like this in **slide format**, **email-ready summary**, or a **status update report**.
