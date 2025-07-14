Here’s a suggested Jira ticket you can raise to the Landing Zone (LZ) team regarding the error:

---

**Title**: 🛠️ Vault LDAP Login Error: Failed to Bind User for Namespace `gcp-qaent-namesspace`

**Project**: LZ Support (or your relevant project name)
**Issue Type**: Bug
**Priority**: High
**Assignee**: LZ Team
**Labels**: `vault`, `ldap`, `auth-failure`, `gcp`, `qaenv`

---

**Description**:

We are encountering an issue when attempting to authenticate with Vault using LDAP for the namespace `gcp-qaent-namesspace`.

---

**Error Details**:

```
Error: Error making API request.

Namespace: gcp-qaent-namesspace  
URL: PUT https://vault.uat.weelsfargo.net/v1/auth/idap/login/GCP_VLT_NP_CORE_IAM  
Status Code: 400

Errors:
* ldap operations failed: failed to bind a user
```

---

**Impact**:

* LDAP authentication to Vault is failing.
* Affects role/service: `GCP_VLT_NP_CORE_IAM`
* This is blocking automation or access to secrets in `gcp-qaent-namesspace`.

---

**Request**:
Please investigate and resolve the LDAP bind issue for the specified namespace and role. Confirm whether the service account `GCP_VLT_NP_CORE_IAM` exists and has the proper LDAP configuration.

---

**Attachments**: *(if you have logs, screenshots, Terraform plan, etc.)*

Let me know if you want this formatted as a Jira `description` field text block or sent via email/Slack template.
