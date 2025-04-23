Phase 1 (PR1): IAM Factory Module Creation
Create a new module in IAM Factory.

The module will handle adding members to a subnet group.

The following will be passed as parameters:

Active APIs

Group name

Logic will ensure that:

Only service agents of the active APIs are added to the group.

All required members are included in the group.

Phase 2 (PR2): Integration with Project Provisioning
Enhance Project Provisioning to:

Pass the group ID to the IAM Factory module.

Pass the active APIs for the current project.

Ensure seamless integration with the IAM Factory module created in Phase 1.

Phase 3 (PR3): Invocation from Project Factory
Update Project Factory to:

Call the IAM Factory module developed in earlier phases.

Ensure that the module is invoked with the correct parameters from the provisioning flow.

Maintain the approach of not modifying core Project Factory code, using extension/integration points where possible.

