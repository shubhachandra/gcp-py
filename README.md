
=IF(ISNUMBER(MATCH(A2, Sheet2!A:A, 0)), "DELETE", "KEEP")
=IFERROR(MID(A2, SEARCH("IpCidrRange", A2), 25), "")

Subject: New Self-Service Subnet Creation Process for Operations Team

Hello Team,

We are introducing a self-service subnet creation process for the operations team. Going forward, you will no longer need to reach out to the network team for subnet creation requests.

Whenever you receive a subnet creation request for AD-ent, this process must be followed. Requests can be for any of the SDLC environments (Non-prod, Prod, or Sandbox).

To proceed:

Open the respective Excel sheet for the requested SDLC environment.
Follow the documented steps provided in our Confluence page (link included).
A recorded walkthrough of the process is also available for reference.
Please refer to the documentation and the recording for a step-by-step guide. Let us know if you have any questions.
