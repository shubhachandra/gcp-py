As per our discussion yesterday, we are carving out IP ranges for us-east4 and us-south1 from the existing allocated range of the core VPC in us-central1 and us-east1.

Additionally, we need to delete the following subnets: subnet1 and subnet2. However, please note that these subnet names are currently referenced 46 times across various repositories.

After deleting the older /20 subnets, I will create new /21 subnets using updated naming conventions. The older subnet names will remain unchanged where the new naming conventions are not yet applied.

Please let me know if you have any concerns.Here's your structured subnet allocation table as requested:

📥 [Download the CSV file](sandbox:/mnt/data/subnet_allocation_table.csv)

---

## Comprehensive Documentation (All Captured Notes):

### 1. **Subnet Reclamation & BGP Advertisement:**
- **Delete unused /20 subnets** allocated for experiments.
- **Create smaller subnets** as `/21` for efficient utilization.
- Split existing `/17` subnet into two `/18` subnets:
  - `100.126.128.0/18` → **us-central1** (Core IP: `100.126.128.17`)
  - `100.126.192.0/18` → **us-east4`
- **Force-update existing Cloud Routers** (no new routers required).

### 2. **Firewall Changes:**
- Submit firewall request to **update firewall objects** with new subnet prefixes (`/18`, `/21`).

### 3. **Third-party Vendor Mapping:**
- **Vendor 1**:
  - Subnet: `100.126.128.0/18` (**us-central1**).
- **Vendor 2**:
  - Subnet: `100.126.192.0/18` (**us-east4**).

### 4. **IP Grouping for Container DDI/IPAM Tool:**

| Field   | Labels/Values                                      |
|---------|----------------------------------------------------|
| env     | `ad-ent`, `qa-ent`, `dev`, `test`, `stage`, `prod` |
| sdlc    | `pci`, `pca`, `standard`                           |
| zone    | `core`, `dmz`, `nonprod`, `prod-discovery`, `sandbox` |
| region  | `us-central1`, `us-east4`, `us-east1`, `us-south1` |
| purpose | `container-workloads`, `vm-workloads`, `kubernetes`, `discovery`, `experiment/test`, `infrastructure` |

### 5. **RFC1918 Address Filtering:**
- Richard will provide subnet list.
- Filter the provided subnet list to retain only RFC1918 ranges:
  - `10.0.0.0/8`
  - `172.16.0.0/12`
  - `192.168.0.0/16`
- Provide cleaned RFC1918-only subnets for **Prod Discovery**.

### 6. **Subnet Allocation Table:**
- Created structured table (`CSV`) with:
  - **Environments**: `AD-ent`, `QA-ent`
  - **SDLCs**: `Sandbox`, `Prod`, `Nonprod`, `Core`, `PAA`, `PCI`, `Prod Discovery`
  - **Regions**: `us-central1`, `us-east1`, `us-east4`, `us-south1`
  - **IP Range Types**: `Routable`, `Nonroutable`, `PUPI`, `RFC1918`
- Allows up to 15 entries per combination.

---

Let me know if you require additional details or further assistance!
