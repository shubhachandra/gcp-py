You’re right—the main alert flow is to BigPanda and ServiceNow, as shown in the diagram. However, as mentioned in the last point of the document, we also need to configure email notifications to ensure alerts are properly actioned.

The reason I’m highlighting this is because most subnet creation is handled by your team (Ops), and it’s important that the networking team is also alerted when such changes occur. Email notifications help ensure relevant teams are looped in, especially in cases where automated integrations might not notify all stakeholders.
⸻

Subject: Clarification on Alert Notification Recipient

Hi Shwet,

As we are using the Observability module, creating alerts for all GCP services is mandatory as part of the Baseman control requirements. This is being enforced through a Sentinel policy to ensure compliance.

For network-related alerts, should these be routed to the Ops team? Can you confirm if the following email address can be used to receive such notifications?

We are proceeding with the default alerting setup, where only specific operational events will trigger notifications. These include:

[List the alert types here]

Please let me know if the recipient and setup are appropriate or if any changes are required.

Best regards,
[Your Name]

⸻

Let me know if you also want a shorter or more informal version.
