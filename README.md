In Terraform, lists (or any values) cannot be used reliably if they are unknown during the plan phase because Terraform must evaluate all expressions, conditions, and loops at plan time, not at apply time. Here’s a clear explanation of why lists cannot be unknown:

⸻

🔍 Why Lists Cannot Be Unknown in Terraform

Terraform evaluates all expressions during the plan phase to generate an execution plan. If a list is marked as unknown, Terraform does not know its contents or even its length at that time. This causes problems in two key scenarios:

1. Using List Values in Conditions

count = local.my_list[0] == "abc" ? 1 : 0

If local.my_list is unknown, Terraform cannot determine whether local.my_list[0] == "abc" is true or false. This leads to a plan-time error because the count value becomes ambiguous.

2. Using List in Loops (for, count, etc.)

[for item in local.my_list : item.name]

Terraform must know the list length to unroll the loop. If the list is unknown, it can’t iterate over it — resulting in an error or invalid plan.

⸻

✅ Why This Happens

Terraform’s execution model is declarative and static:
	•	It must determine all resources and their dependencies before applying any changes.
	•	It does not support dynamic code execution at apply time, which means all variables used in logic or resource meta-arguments (count, for_each, etc.) must be fully known at plan time.

⸻

✅ Best Practice
	•	Avoid constructing lists based on values from data blocks unless those data outputs are guaranteed to be known at plan time.
	•	Consider using count or for_each conditionally outside of unknown-dependent logic.

⸻

If you’re generating a list based on the existence of a service account (which is fetched via data.google_service_account), that data source may not return a known result at plan time (especially if the service account does not yet exist or depends on another resource).

Let me know if you want a Terraform-safe workaround.
