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

### 🟨 Scenario 1: Single Subnet for All Services

**Table 4: Scenario 1 - Single Subnet Allocation**

| Service            | CIDR Required | IP Address Count | CIDR Allocated             | Resources Consumed                  | Usage    | Concurrent Jobs |
|--------------------|---------------|------------------|----------------------------|-------------------------------------|----------|-----------------|
| Cloud Composer     | `/27`         | 32               | Single Shared Subnet (`/26`) | Workflow management environment     | 🔴 Heavy | 🔴 High         |
| Cloud Dataflow     | `/28`         | 16               |                            | Data pipelines (streaming/batch)    | 🟠 Medium | 🟠 Medium       |
| **Total**          | **`/27 + /28`** | **48**          | **`/26 (64 IP addresses allocated)`** |                                     |          |                 |

**Pros:**
- ✅ Optimal subnet size to accommodate heavy Composer usage and medium Dataflow usage
- ✅ Simplified management and routing
- ✅ Efficient IP address utilization

**Cons:**
- ⚠️ Limited additional IP addresses for future growth
- ⚠️ Reduced isolation between Composer and Dataflow

### 🟪 Scenario 2: Separate Subnets for Each Service

**Table 5: Scenario 2 - Individual Subnet Allocation**

| Service            | CIDR Required | IP Address Count | CIDR Allocated (Individual) | Resources Consumed               | Usage    | Concurrent Jobs |
|--------------------|---------------|------------------|-----------------------------|----------------------------------|----------|-----------------|
| Cloud Composer     | `/27`         | 32               | `/27`                       | Workflow management environment  | 🔴 Heavy | 🔴 High         |
| Cloud Dataflow     | `/28`         | 16               | `/28`                       | Data pipelines (streaming/batch) | 🟠 Medium | 🟠 Medium       |
| **Total**          |               | **48**           | **48 IP addresses allocated** |                                  |          |                 |

**Pros:**
- ✅ Enhanced security and isolation
- ✅ Easier service-specific management

**Cons:**
- ⚠️ Increased complexity in subnet management
- ⚠️ Higher administrative overhead
- ⚠️ Less efficient IP utilization

## 🎯 Recommendation
**Recommended Scenario:** 🟨 **Scenario 1 (Single Subnet)**
- ✅ Provides adequate capacity for heavy Composer and medium Dataflow usage
- ✅ Offers simpler operational management and efficient IP utilization
- ✅ Balanced approach between flexibility, growth potential, and resource management

