
=IF(ISNUMBER(MATCH(A2, Sheet2!A:A, 0)), "DELETE", "KEEP")
=IFERROR(MID(A2, SEARCH("IpCidrRange", A2), 25), "")

A Jira ticket has been created for this issue, and we are actively working on mitigating it. This issue is being flagged due to the Sentinel policy that was rolled out a couple of days ago.

We have already flagged this for an update, and you can refer to the Jira ticket [Ticket ID] for further details. Please let me know if you need any additional information.
