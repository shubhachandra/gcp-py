Here’s a clearer and more structured version of your message for better readability and clarity:

---

We previously encountered a **policy binding error (400)** due to exceeding the limit of **1,500 members** at the subnet level. We initially fixed the issue based on what we believed was the root cause. However, we later observed that **members were being added at the host project level**, which also reached the same limit, resulting in a recurrence of the error.

To address this, we introduced a **fix in version 4.2.2**. Prior to that, **version 4.2.1 was released in the last week of April**, and by the **second week of May**, the issue resurfaced. This happened because a few projects were upgraded from older versions to **4.2.1**, and during the upgrade, **service agents were added at the host project level**, pushing it over the limit.

Currently, the main issue is that **some projects are still running version 4.2.1** and haven’t been upgraded to 4.2.2. I have identified **8 such projects**, each with **up to 42 service agent entries**. With Nagabhushan’s help, we upgraded these projects, successfully removing **around 40 service accounts** from the host project.

I’m attaching the evidence for this cleanup.

**Request to the Ops team:**
Please list all PRs from **April 28 onward** and check if they are still using **version 4.2.1**. If so, kindly **upgrade them to 4.2.2**. We estimate that doing so could help us **reduce around 250 service account entries**, which is our immediate mitigation step.

In parallel, we’re in touch with **Google support to request an increase in the member limit**, but since it's a feature request, we’ll share updates as we hear back.

---

Let me know if you'd like to turn this into an email or formal report.
