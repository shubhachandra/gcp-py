Hi Team,

The Network Connectivity service account (gcp-sa-networkconnectivity) is a Google-managed identity considered external by our group policies.

There is no way to exempt just this account without opening the group to all external members, which we cannot allow under current org policy.

Dataflow’s service agent was allowed because our policy treats project-level service agents (like dataflow-service-producer-prod) as acceptable external members, while gcp-sa- service accounts are classified as fully Google-controlled and therefore blocked.

As you have already tested, assigning the Subnet User role directly works. We can proceed by applying this in the wf-custom module using the required flag.

Since the number of Dialogflow projects is low, adding the policy binding directly should not hit IAM policy limits.
