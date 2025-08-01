Here’s a comprehensive design document for your **Homegrown IPAM Tool**, including the **functional requirements**, **database design**, and **workflow explanations**:

---

## ✅ IPAM Tool – Design Document

### 🔹 Purpose

To manage, allocate, and track IP subnets within predefined ranges based on region, SDLC environment, and CIDR sizes.

---

## 📦 1. Master Database Design (`master_ipam` table)

| Column Name   | Data Type     | Description                                                             |
| ------------- | ------------- | ----------------------------------------------------------------------- |
| `cidr_range`  | VARCHAR (20)  | CIDR range e.g., `100.124.0.0/18` — **Primary Key**                     |
| `size`        | VARCHAR (5)   | Subnet size `/17`, `/18`, etc. — used for grouping                      |
| `subnet_name` | VARCHAR (255) | Name of the subnet in GCP (or any cloud); can be NULL if unallocated    |
| `no_of_ips`   | INTEGER       | Calculated from size — number of usable IPs                             |
| `region`      | VARCHAR (100) | GCP region like `us-central1`, `us-east1`                               |
| `sdlc`        | VARCHAR (50)  | Environment type: `prod`, `nonprod`, `sandbox`, `core`, `pdisco`, `paa` |
| `date`        | DATE          | Date of allocation; NULL if not allocated                               |
| `status`      | VARCHAR (20)  | `available`, `reserved`, `unavailable`, `planned`                       |

#### Additional Notes:

* Supernetting and subnetting logic should ensure no conflicting overlaps.
* Every subnet creation will check and track parent-child relationships in logic (not stored explicitly in DB).

---

## 🛠️ 2. Functional Requirements

### A. Subnet Generator (UI Function #1)

**Purpose:** To generate all possible subnets between a given range (e.g. `/17` to `/29`), and insert them into the DB.

#### Input Parameters:

* `CIDR Range`: e.g., `100.126.0.0/17`
* `Smallest Subnet`: e.g., `/29`
* `Region`: user-specified
* `SDLC`: user-specified

#### Behavior:

* Auto-calculate all valid subnets from /17 to /29 (inclusive).
* Insert into `master_ipam` with `status = 'available'`, `date = NULL`, `subnet_name = NULL`.
* Calculate number of IPs based on CIDR using: `2^(32 - subnet_size) - 2`.

---

### B. IPAM Management Functions

#### 1. **Reserve a Single Range** (UI Function #2b)

* User selects an `available` CIDR range.
* System:

  * Sets selected range `status = 'reserved'`, `date = today()`, `subnet_name = input`.
  * Finds all supernets and subnets → marks them as `unavailable`.

#### 2. **Bulk Update via CSV** (UI Function #2a)

* CSV Format:

  * `cidr_range`, `subnet_name`, `region`, `sdlc`, `date`, `status`
* Validations:

  * Only `available` ranges should be updated to `reserved`.
  * Related subnets/supernets updated accordingly.

#### 3. **Reclaim Function**

* Reverse the allocation:

  * Target range marked `available`, `subnet_name = NULL`, `date = NULL`, `status = available`
  * Also update all subnets and supernets that were made unavailable due to this.

---

### C. Dashboard & Analytics

#### 1. **CIDR Summary Dashboard (UI Function #3)**

* Filters:

  * Region, SDLC, Status
* Output:

  * `/24: 10 available`
  * `/25: 5 reserved`
  * `/29: 8 planned`
  * ... grouped by `size`

#### 2. **List Ranges**

* Filter by:

  * Region, SDLC, CIDR size, Status
* Display IP ranges
* Action: Mark selected IPs as "planned" (status = `planned`)

---

## 🧩 3. System Components

| Component               | Description                                                                |
| ----------------------- | -------------------------------------------------------------------------- |
| **UI/Frontend**         | Web interface (React/Angular) to interact with DB and perform CRUD actions |
| **Backend/API**         | REST API (Python Flask / NodeJS / Go) for logic, CSV parsing, validation   |
| **Database**            | PostgreSQL / MySQL — host `master_ipam` table                              |
| **IP Calculator Logic** | Library/function to calculate subnets, supernets, and IP availability      |

---

## 🔄 Supernet & Subnet Status Logic

When **reserving** a CIDR block:

* Set that CIDR to `reserved`
* Mark all subnets and supernets of this CIDR as `unavailable`

When **reclaiming** a CIDR block:

* Set that CIDR to `available`
* If no overlapping CIDRs are reserved → mark subnets/supernets also as `available`

---

## 🧪 Example Entry

| cidr\_range     | size | subnet\_name  | no\_of\_ips | region      | sdlc | date       | status      |
| --------------- | ---- | ------------- | ----------- | ----------- | ---- | ---------- | ----------- |
| 100.124.0.0/18  | /18  | subnet-prod-1 | 16382       | us-central1 | prod | 2025-08-01 | reserved    |
| 100.124.0.0/19  | /19  |               | 8190        | us-central1 | prod |            | unavailable |
| 100.124.64.0/19 | /19  |               | 8190        | us-central1 | prod |            | available   |

---

## 🔧 Optional Enhancements

* **Audit Log Table**: For every update (reserve, reclaim, plan).
* **History Tracking**: Show previous subnet\_name, date of change.
* **Tagging**: Add optional tags like `owner`, `project`.

---

Would you like:

* The **ER diagram** for DB design?
* Sample **CSV template**?
* **UI mockup** or **VBA integration** for your Excel version?

Let me know what you'd like to build next.
