Thanks, Shubh! Here’s the updated Point 2, rewritten for clarity and integrated into the full structure:

⸻

Clarification on Shared VPC Host Projects and IAM Bindings

Point 1:
The statement “Shared VPC host projects have principals with access to all subnets” is outdated.
	•	Starting from Project Factory version 4.2.2, this was addressed during the policy binding changes.
	•	We no longer assign the compute.networkUser role at the host VPC level.
	•	Instead, we provide subnet-level IAM access specifically for shared subnets, using Google Groups:
	•	A group is created in each networking spoke repository.
	•	Subnet-level IAM roles are assigned to these groups.
	•	Service agents are automatically added to these groups by Project Factory v4.2.2+.

Point 2:
The statement “219 service projects have access to all subnets” is no longer true.
	•	We now use four shared dedicated subnets located in:
	•	us-central1, us-east1, us-east4, and us-south1.
	•	These subnets are managed through Google-native groups, with subnet IAM roles defined in the networking repo.
	•	When a new service project is created (e.g., hosting GKE or Composer):
	•	It is assigned its own dedicated subnet from the predefined regional subnets.
	•	The project’s service agent receives IAM binding only to that specific subnet, not to all subnets.

Point 3:
The statement “821 principals with compute.networkUser on host projects (acting as service project admins)” is outdated.
	•	In the updated model, no principal receives compute.networkUser at the host project level.
	•	IAM roles are applied only at the subnet level, via group-based bindings to maintain least privilege.

Point 4:
There are approximately 7,538 subnet-level compute.networkUser bindings, implemented via Google Group membership.
	•	These groups have access only to shared subnets, not to application-specific dedicated subnets.
	•	The key point for discussion is:
“Why do service projects require access to shared subnets?”
— which should be clearly documented and justified.

⸻

Let me know if you’d like this formatted as a formal comment, email, or attached to a review note.
