Perfect! Here's the updated **Jira story** with that context added for clarity and use-case alignment 👇

---

**Title**: Define Output Variables for Well-Known IP Prefixes for Firewall Rule Reuse

**Description**:  
To streamline the creation and management of network firewall rules across cloud platforms, define Terraform output variables for well-known IP prefixes. These variables will be reusable across multiple Terraform modules, enabling consistent policy enforcement and simplified referencing.

This will include public, private, and special-use IP ranges, including those used by Wells Fargo and other known third parties, as referenced in the shared PPT.

---

**Scope of Work**:

1. **Define IP Prefixes**:
   - Wells Fargo public IPs
   - RFC1918 (Private IP ranges)
   - RFC6598 (Carrier-grade NAT)
   - Squat space IPs
   - 3rd-party vendor IPs (from PPT)

2. **Terraform File Structure**:
   - `wf-generic-prefixes.tf`: Wells Fargo & common IPs.
   - `gcp-prefixes.tf`: Google Cloud service ranges (e.g., APIs, DNS).
   - `azure-prefixes.tf`: Azure service IPs (e.g., VNet service tags).

3. **Output Variables**:
   - Use `output` blocks for each logical IP group.
   - Example:  
     ```hcl
     output "rfc1918_prefixes" {
       value = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
       description = "RFC1918 private IP ranges"
     }
     ```
   - Prefix variables will be referenced in firewall rules to avoid hardcoding IPs.

4. **Documentation**:
   - Add inline comments and source references for each IP range.
   - Ensure each `.tf` file is scoped by platform and usage (e.g., infra vs application).

---

**Acceptance Criteria**:

- [ ] Output variables defined for all categorized IP ranges.
- [ ] Variables available for use in firewall rule modules across environments.
- [ ] File structure follows naming convention: `wf-generic-prefixes.tf`, `gcp-prefixes.tf`, `azure-prefixes.tf`.
- [ ] Documentation and inline comments provided for all outputs.
- [ ] Validated via plan and peer reviewed.
- [ ] Merged into shared Terraform module repo.

---

Let me know if you'd like a starter template for the `.tf` files or sample usage in a firewall module 💡
