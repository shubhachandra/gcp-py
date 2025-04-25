There is an update regarding the mitigation of the 1500 IAM binding limit issue. We have completed testing in the QA environment using a group-based approach. Specifically, we plan to remove the networkUser role from individual service accounts and instead assign it to a Google Group, with all relevant API service accounts added to that group.

We are in the final stage of testing in the QA environment. We now request this ticket be expedited for implementation in the non-prod environment to mitigate the ongoing issue.

We request the team to treat this item with the highest priority.
