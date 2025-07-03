Hi Team,

We usually see this issue specifically with the Network Connectivity service account. Since Google Groups does not support exceptions for a single external member, and updating the group to allow external members would open membership to all domains, we cannot modify the org policy to permit this.

As you have already tested assigning the Subnet User role directly, we can proceed with that approach. Let’s incorporate this change into the wf-custom module using the module’s required flag.

Given that the number of projects leveraging Dialogflow is minimal, adding this service account directly to the subnet IAM policy should not cause any policy binding limit issues.

Please let me know if you have any concerns, otherwise we can move forward with these updates.
