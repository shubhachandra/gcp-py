## 🟦 Subnet Guidelines for Composer with Tee Size

**Table 1: Subnet Guidelines and Tee Size Allocation**

| Tee Size       | Primary Range | Secondary Range | Service Range |
|----------------|---------------|-----------------|---------------|
| Micro-XS       | `/28`         | `/23`           | `/27`         |
| Small-S        | `/27`         | `/22`           | `/26`         |
| Medium-M       | `/26`         | `/21`           | `/25`         |
| Large-L        | `/25`         | `/20`           | `/24`         |
| Extra Large-XL | `/24`         | `/19`           | `/18`         |

## 🟩 Derived Decision After Reasoning, Resources, and Questionnaire Exercise with Archetype Team

**Table 2: Archetype Specification and Selected Tee Size**

| Archetype Name                 | Data Pipeline Archetype Specification |
|--------------------------------|---------------------------------------|
| Tee Size Selected              | 🟢 **Extra Large (XL)**                |
| Primary CIDR Range             | `/16 (65,536 IP addresses)`           |
| Secondary CIDR Range           | `/19`                                 |
| Service CIDR Range             | `/18`                                 |
| Resources Not Used             | ❌ Vertex AI Workbench, Notebooks, Cloud SQL |

---

## 📌 Controlled Data Movement Archetype Specification

**Table 3: Archetype Specification and Selected Tee Size**

| Archetype Name                 | Controlled Data Movement Archetype Specification |
|--------------------------------|----------------------------------------------|
| Tee Size Selected              | 🟢 **Medium (M)**                             |
| Primary CIDR Range             | `/26 (64 IP addresses)`                      |
| Secondary CIDR Range           | `/21`                                        |
| Service CIDR Range             | `/25`                                        |
| Resources Not Used             | ❌ Vertex AI Workbench, Notebooks, Cloud SQL, Dataproc |

---

## 📌 AIML Model Dev & Training Archetype Specification

**Table 4: Archetype Specification and Selected Tee Size**

| Archetype Name                 | AIML Model Dev & Training Archetype Specification |
|--------------------------------|---------------------------------------------------|
| Tee Size Selected              | 🟢 **Large (L)**                                   |
| Primary CIDR Range             | `/25 (128 IP addresses)`                          |
| Secondary CIDR Range           | `/20`                                             |
| Service CIDR Range             | `/24`                                             |
| Resources Used                 | ✅ Composer, Dataproc, Dataflow, Vertex AI Workbench, Notebooks |

### 🟨 Scenario 1: Single Subnet for All Services

**Table 5: Scenario 1 - Single Subnet Allocation**

| Service            | CIDR Required | IP Address Count | CIDR Allocated             | Resources Consumed                 | Usage    | Concurrent Jobs |
|--------------------|---------------|------------------|----------------------------|------------------------------------|----------|-----------------|
| Cloud Composer     | `/27`         | 32               | Single Shared Subnet (`/25`) | Workflow management environment    | 🔴 Heavy | 🔴 High         |
| Cloud Dataproc     | `/27`         | 32               |                            | Hadoop/Spark clusters              | 🔴 Heavy | 🔴 High         |
| Cloud Dataflow     | `/28`         | 16               |                            | Data pipelines (streaming/batch)   | 🟠 Medium | 🟠 Medium       |
| Vertex AI Workbench/Notebooks | `/28` | 16            |                            | AI model development/training      | 🟠 Medium | 🔵 Low          |
| **Total**          | **`2×/27 + 2×/28`** | **96**     | **`/25 (128 IP addresses allocated)`** |                                 |          |                 |

**Pros:**
- ✅ Efficient utilization of IP addresses
- ✅ Simplified subnet management
- ✅ Flexible resource allocation for various services

**Cons:**
- ⚠️ Reduced isolation between services
- ⚠️ Potential security concerns

## 🎯 Recommendation
**Recommended Scenario:** 🟨 **Scenario 1 (Single Subnet)**
- ✅ Ideal for AIML development & training with diverse resource requirements
- ✅ Balances ease of management with operational efficiency
- ✅ Provides adequate IP addresses for growth and flexibility

