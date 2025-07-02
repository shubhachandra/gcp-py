Here’s a **clear and professional email draft** you can use to communicate this process to the **application teams**. Feel free to copy-paste and adjust the greeting or sign-off as needed.

---

**Subject:** Notification: Subnet Reclamation Process – Action Required

---

Hi Team,

As part of our ongoing network hygiene and IP optimization initiative, we are implementing a **subnet reclamation process** to identify and remove subnets that have remained unused for more than 90 days.

Going forward, you may receive emails from our Ops/Network team highlighting subnets associated with your projects that:

* Have not been used for more than 90 days
* Appear to have no associated resources (e.g., VM instances, GKE clusters, Composer environments, or notebooks)

**What you need to know:**
✅ When you receive such a notification, please **review the subnet details carefully**.
✅ If the subnet is still required, please reply within **5 business days** with a valid justification to retain it.
✅ If no response is received within 5 business days, we will assume the subnet is safe for deletion and proceed accordingly.

Our teams will coordinate the deletion through Terraform after final validation to ensure there is no impact on active resources.

We also request your **cooperation** to promptly respond to these emails, and proactively let us know if you have any subnets no longer in use that we can reclaim — this will help us keep the environment clean and improve provisioning turnaround times for everyone.

Thank you for your support and collaboration in keeping our network resources optimized.

If you have any questions or concerns about this process, please feel free to reach out.

Best regards,
**\[Your Name]**
Network Engineering Team
\[Optional: add distribution list or ticket reference]

---

If you want, I can help you adapt this for a Confluence announcement or Slack post too — just let me know!
