**Summary:**
Create GCP Project with BigQuery Data Editor role and Dataset for Network Analyzer Logs

**Description:**

As part of the NIC: GCP Network Analyzer initiative, this subtask involves the following actions:

1. **Create a new GCP Project:**
   - Follow the agreed-upon naming conventions.

2. **Assign Roles:**
   - Ensure the BigQuery Data Editor (`roles/bigquery.dataEditor`) role is assigned to the required service account/user.

3. **Create BigQuery Dataset:**
   - Name the dataset appropriately for logging purposes (e.g., `network_analyzer_logs`).

4. **Set up Export for Cloud Logging:**
   - Configure log sinks in Cloud Logging to export Network Analyzer-related logs directly into the newly created BigQuery dataset.
   - Ensure logs are filtered specifically for Network Analyzer events.

**Acceptance Criteria:**
- [ ] GCP Project is created with correct naming.
- [ ] BigQuery Data Editor role assigned appropriately.
- [ ] BigQuery Dataset is created successfully.
- [ ] Network Analyzer logs are properly exporting to the BigQuery dataset.

**Dependencies:**
- NIC: GCP Network Analyzer (parent task)

**Assignee:**
(Assign accordingly)

**Priority:**
(Mark as per project requirement)

**Due Date:**
(Provide relevant date)

