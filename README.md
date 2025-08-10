
Got it — you want a clear, structured onboarding Confluence page for new GCP networking team members that explains the process for entitlement requests (AIMS & ART), dependencies, environment access, required tools, and approval follow-ups.

Here’s a refined and structured draft you can directly paste into Confluence (with headings, bullet points, and instructions for better readability).

⸻

GCP Networking Team – Onboarding Guide

Welcome to the ACT GCP Networking Team. This guide outlines the steps and required access for working in our AD ENT and QA-ENT (Sandbox) environments.

⸻

1. AD ENT Environment – Entitlement Request Process (AIMS)

In the AD ENT environment, you will need to request several entitlements via the AIMS portal.
Some entitlements have dependencies and must be requested in a specific order.

Step-by-Step Process:
	1.	Access the AIMS portal and add all required entitlements from the provided entitlement table into your cart.
	2.	Attempt to submit the request.
	•	If you receive an error due to entitlement dependency, remove the conflicting entitlements from the cart.
	3.	Submit the remaining entitlements that do not trigger errors.
	4.	Track your submitted entitlements in the provided Excel tracker.
	5.	Once your manager approves these, repeat the process:
	•	Add the next set of entitlements to your cart.
	•	Submit and repeat until all entitlements are approved.
	6.	You can view your approved entitlements via the Group Grader link provided here.

Justification format for AIMS requests:
"As a part of ACT GCP Networking Team, I need these access permissions for my daily tasks."

⸻

2. QA-ENT (Sandbox) Environment – ART Requests

The QA-ENT environment is used for various testing activities.
To work in this environment:
	1.	Create an account via the ART request link provided here.
	2.	Request the required roles listed in the entitlement table for QA-ENT.
	3.	Ensure you are part of the correct entitlement groups (list provided here).

Justification format for ART requests:
"As a part of ACT GCP Networking Team, I need these access permissions for my daily tasks."

⸻

3. Required Applications & Tools

You will need the following tools installed on your Cloud PC:
	•	VS Code – for editing and configuration
	•	Terraform (Enterprise) – for resource creation
	•	Google Cloud SDK – built on Python for CLI-based GCP operations
	•	Git – for version control
	•	Python – for scripting and SDK usage

Installation Process:

Request installation via the Software Market on your Cloud PC.

Setup Guides:
	•	Terraform Setup Guide
	•	Git Setup Guide
	•	Python Setup Guide
	•	Google Cloud SDK Setup Guide

⸻

4. Working with CLI & Terraform
	•	Access to Enterprise Terraform is required to deploy GCP resources.
	•	You will primarily work via CLI commands and Terraform scripts.
	•	Ensure your Google Cloud SDK is authenticated with your approved entitlements before running commands.

⸻

5. Approval Follow-Up Best Practices
	•	After submitting requests, check your email for first-level and second-level approvers.
	•	Reach out to approvers via Teams chat or a short email note to expedite approvals.
	•	Keep your manager updated about pending requests.

⸻

✅ Once you complete all steps, you will have access to both AD ENT and QA-ENT environments, required tools, and the ability to work on GCP networking tasks using Terraform, CLI, and other team tools.

⸻

If you want, I can also add a dependency flow diagram for the entitlement request process so new hires can see the approval chain visually. This would make the guide even easier to follow.

Do you want me to create that diagram next?
