Below are two tables: one summarizes the detailed current environment allocations (across us‑central1 and us‑east1), and the second shows the new IP ranges for additional regions.

---

### Table 1: Current Environment IP Allocations

| Environment | Region      | IP Range            | /18 | /19 | /20 | /21 | /22 | /23 | /24 | /25 | /26 | /27 | /28 | Remaining IPs | Additional /27 Subnets |
|-------------|-------------|---------------------|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|-----|---------------|------------------------|
| Sandbox     | us‑central1 | 100.126.0.0/17      | 1   | 0   | 1   | 1   | 3   | 0   | 12  | 9   | 18  | 12  | 4   | 15,136        | 473                    |
| Sandbox     | us‑east1    | 100.123.0.0/17      | 1   | 0   | 1   | 2   | 1   | 2   | 4   | 5   | 3   | 7   | 1   | 13,808        | 431                    |
| Prod        | us‑central1 | 100.124.128.0/17    | 1   | 0   | 1   | 1   | 3   | 0   | 12  | 9   | 18  | 12  | 4   | 1,344         | 42                     |
| Prod        | us‑east1    | 100.125.128.0/17    | 1   | 0   | 1   | 2   | 1   | 2   | 4   | 5   | 3   | 7   | 1   | 4,048         | 126                    |
| Nonprod     | us‑central1 | 100.124.0.0/17      | 1   | 0   | 1   | 1   | 3   | 0   | 13  | 13  | 17  | 8   | 5   | 752           | 23                     |
| Nonprod     | us‑east1    | 100.125.0.0/17      | 1   | 0   | 0   | 1   | 2   | 0   | 3   | 5   | 4   | 4   | 1   | 6,640         | 207                    |
| Core        | us‑central1 | 100.126.128.0/17    | 0   | 0   | 1   | 0   | 0   | 0   | 2   | 0   | 1   | 1   | 1   | 28,032        | 28,672                 |
| Core        | us‑east1    | 100.123.128.0/17    | 0   | 0   | 1   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 28,672        | 896                    |

---

### Table 2: New Region IP Allocations

| Region   | Environment | Allocated IP Range  |
|----------|-------------|---------------------|
| us‑south1| Prod        | 100.67.0.0/16       |
| us‑south1| Nonprod     | 100.71.0.0/16       |
| us‑south1| Sandbox (Dev)| 100.74.0.0/16      |
| us‑south1| Core (Hub)  | 100.75.0.0/16       |
| us‑east4 | Prod        | 100.85.0.0/16       |
| us‑east4 | Nonprod     | 100.86.0.0/16       |
| us‑east4 | Sandbox (Dev)| 100.87.0.0/16      |
| us‑east4 | Core (Hub)  | 100.88.0.0/16       |

---

These tables combine all the detailed allocations and remaining capacities for your current SDLC environments as well as the new IP ranges for the additional regions.

Below are three tables that summarize your non‐routable IP space allocation. The first table shows the SDLC allocations for PAA, nonprod, Sandbox, and Prod across four regions. The second table lists the reserved /15 ranges for future SDLC or feature usage. The third table shows the additional large ranges reserved for future usage.

---

### Table 1: SDLC IP Allocations (/15 Blocks)

| Environment | Region      | IP Range       |
|-------------|-------------|----------------|
| PAA         | us‑central1 | 100.0.0.0/15   |
| PAA         | us‑east1    | 100.2.0.0/15   |
| PAA         | us‑south1   | 100.4.0.0/15   |
| PAA         | us‑east4    | 100.6.0.0/15   |
| Nonprod     | us‑central1 | 100.8.0.0/15   |
| Nonprod     | us‑east1    | 100.10.0.0/15  |
| Nonprod     | us‑south1   | 100.12.0.0/15  |
| Nonprod     | us‑east4    | 100.14.0.0/15  |
| Sandbox     | us‑central1 | 100.16.0.0/15  |
| Sandbox     | us‑east1    | 100.18.0.0/15  |
| Sandbox     | us‑south1   | 100.20.0.0/15  |
| Sandbox     | us‑east4    | 100.22.0.0/15  |
| Prod        | us‑central1 | 100.24.0.0/15  |
| Prod        | us‑east1    | 100.26.0.0/15  |
| Prod        | us‑south1   | 100.28.0.0/15  |
| Prod        | us‑east4    | 100.30.0.0/15  |

*Rationale:* A /15 allocation provides enough /26 subnets to meet the current average requirement (below 15 subnets per month) while allowing for roughly one year of usage and future scalability.

---

### Table 2: Reserved /15 Ranges for Future Usage

| Reserved IP Range  | Purpose                           |
|--------------------|-----------------------------------|
| 100.32.0.0/15      | Reserved for future SDLC/region   |
| 100.34.0.0/15      | Reserved for future SDLC/region   |
| 100.36.0.0/15      | Reserved for future SDLC/region   |
| 100.38.0.0/15      | Reserved for future SDLC/region   |
| 100.40.0.0/15      | Reserved for future SDLC/region   |
| 100.42.0.0/15      | Reserved for future SDLC/region   |
| 100.44.0.0/15      | Reserved for future SDLC/region   |
| 100.46.0.0/15      | Reserved for future SDLC/region   |
| 100.48.0.0/15      | Reserved for future SDLC/region   |
| 100.50.0.0/15      | Reserved for future SDLC/region   |
| 100.52.0.0/15      | Reserved for future SDLC/region   |
| 100.54.0.0/15      | Reserved for future SDLC/region   |
| 100.56.0.0/15      | Reserved for future SDLC/region   |
| 100.58.0.0/15      | Reserved for future SDLC/region   |
| 100.60.0.0/15      | Reserved for future SDLC/region   |
| 100.62.0.0/15      | Reserved for future SDLC/Future  |

---

### Table 3: Additional Future Usage Ranges

| Additional Future Range | Description             |
|-------------------------|-------------------------|
| 100.128.0.0/10          | Future usage            |
| 100.192.0.0/10          | Future usage            |
| 1.0.0.0/8               | Future usage            |

---

These tables clearly document the current non‑routable IP allocations for your SDLC environments along with reserved ranges for both near-term future SDLC needs and larger future expansion.

Below is a consolidated view of the updated IP demarcation plan for PUPI. Each environment’s overall block is divided into /12 segments, with dedicated regions for current usage and reserved blocks for future needs.

---

### PUPI‑Sandbox  
**Overall Block:** 30.0.0.0/8

| IP Block       | Assigned Region / Status         |
|----------------|----------------------------------|
| 30.0.0.0/12   | Dedicated for us‑central1        |
| 30.16.0.0/12  | Dedicated for us‑east1           |
| 30.32.0.0/12  | Dedicated for us‑south1          |
| 30.48.0.0/12  | Dedicated for us‑east4           |
| 30.64.0.0/12  | Reserved for future use          |
| 30.80.0.0/12  | Reserved for future use          |
| 30.96.0.0/12  | Reserved for future use          |
| 30.112.0.0/12 | Reserved for future use          |
| 30.128.0.0/12 | Reserved for future use          |
| 30.144.0.0/12 | Reserved for future use          |
| 30.160.0.0/12 | Reserved for future use          |
| 30.176.0.0/12 | Reserved for future use          |
| 30.192.0.0/12 | Reserved for future use          |
| 30.208.0.0/12 | Reserved for future use          |
| 30.224.0.0/12 | Reserved for future use          |
| 30.240.0.0/12 | Reserved for future use          |

*Rationale:* The existing partial assignment in 30.0.0.0/12 (shared by us‑central1 and us‑east1) will now be dedicated solely to us‑central1. New assignments for us‑east1, us‑south1, and us‑east4 will come from the next available /12 blocks.

---

### PUPI‑Nonprod  
**Overall Block:** 22.0.0.0/8

| IP Block       | Assigned Region / Status         |
|----------------|----------------------------------|
| 22.0.0.0/12   | Dedicated for us‑central1        |
| 22.16.0.0/12  | Dedicated for us‑east1           |
| 22.32.0.0/12  | Dedicated for us‑south1          |
| 22.48.0.0/12  | Dedicated for us‑east4           |
| 22.64.0.0/12  | Reserved for future use          |
| 22.80.0.0/12  | Reserved for future use          |
| 22.96.0.0/12  | Reserved for future use          |
| 22.112.0.0/12 | Reserved for future use          |
| 22.128.0.0/12 | Reserved for future use          |
| 22.144.0.0/12 | Reserved for future use          |
| 22.160.0.0/12 | Reserved for future use          |
| 22.176.0.0/12 | Reserved for future use          |
| 22.192.0.0/12 | Reserved for future use          |
| 22.208.0.0/12 | Reserved for future use          |
| 22.224.0.0/12 | Reserved for future use          |
| 22.240.0.0/12 | Dedicated for us‑central1        |

*Note:* Both 22.0.0.0/12 and 22.240.0.0/12 were previously partially assigned between us‑central1 and us‑east1. Under the new plan, neither will be assigned to us‑east1—they will be dedicated to us‑central1. The remaining blocks are reserved for future usage.

---

### PUPI‑Prod  
**Overall Block:** 11.0.0.0/8

| IP Block       | Assigned Region / Status         |
|----------------|----------------------------------|
| 11.0.0.0/12   | Dedicated for us‑central1        |
| 11.16.0.0/12  | Dedicated for us‑east1           |
| 11.32.0.0/12  | Dedicated for us‑south1          |
| 11.48.0.0/12  | Dedicated for us‑east4           |
| 11.64.0.0/12  | Reserved for future use          |
| 11.80.0.0/12  | Reserved for future use          |
| 11.96.0.0/12  | Reserved for future use          |
| 11.112.0.0/12 | Reserved for future use          |
| 11.128.0.0/12 | Reserved for future use          |
| 11.144.0.0/12 | Reserved for future use          |
| 11.160.0.0/12 | Reserved for future use          |
| 11.176.0.0/12 | Reserved for future use          |
| 11.192.0.0/12 | Reserved for future use          |
| 11.208.0.0/12 | Reserved for future use          |
| 11.224.0.0/12 | Reserved for future use          |
| 11.240.0.0/12 | Dedicated for us‑central1        |

*Note:* Similar to the nonprod case, the partially assigned blocks 11.0.0.0/12 and 11.240.0.0/12 will be dedicated to us‑central1. New assignments for us‑east1, us‑south1, and us‑east4 will use the specified blocks, and the remaining blocks are reserved for future use.

---

This updated plan dedicates specific /12 blocks to each region—ensuring that no new allocations are made in the previously shared blocks for us‑east1—and reserves ample capacity for future expansion or new SDLC requirements.
