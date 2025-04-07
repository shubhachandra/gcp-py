Jira Feature: Infrastructure Setup for Non-Managed Notebook Instances

Description:
This feature involves creating necessary infrastructure components for Non-Managed Notebook instances, structured into multiple sub-stories for clarity and manageability.

Sub-story 1: Create Subnets

Regions: us-central1 (usc1), us-east1 (use)

SDLC Environments: prod, nonprod, sandbox

Subnet CIDR: /18 block for each combination, resulting in a total of 6 subnets.

Naming Convention: <sdlcname>-netb-ainotebook-<region>-<IP details>

Example: prod-netb-ainotebook-usc1-100-126-183-128-27

Where:

prod represents the SDLC name.

netb and ainotebook are standard naming conventions.

usc1 refers to us-central1, and use refers to us-east1.

Sub-story 2: Create AD Groups and Bind to Subnets

Purpose: Create dedicated AD groups and bind notebook instances to their respective subnets.

Ownership and Management:

Clearly document that AD group ownership belongs to Dinesh's team, as they own the application.

Dinesh’s team must approve user access; approved users will gain visibility of the corresponding subnet.

Coordination:

Work closely with the Landing Zone and IAM teams to ensure smooth implementation.

Reason for AD Groups:

AD groups address the limitation of IAM policy, which currently has a maximum of 1500 principals—a limit that has already been reached.

Notes:

Ensure comprehensive documentation detailing subnet and AD group setup.

Clearly outline approval workflows involving Dinesh’s team.

Confirm coordination completion with Landing Zone and IAM teams.

Acceptance Criteria:

