Subject: Clarification on API Usage and QA to AD Environment Transition

Hi [Recipient’s Name],

Noted. Regarding the APIs — these are the same ones currently used in the Project Factory.

API Assumption:
We will attempt to add 7 service agents. Only the active API service agents will be successfully added; the inactive ones will fail and will not be included.

QA to AD Environment Transition:
We need to perform one round of testing in the QA environment before moving the group ID to the Project Provisioning repo. Once confirmed, the group ID will be passed from the Project Provisioning repo to the Project Factory repo.
