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
| Tee Size Selected              | 🟢 **Large (L)**                       |
| Primary CIDR Range             | `/25 (128 IP addresses)`              |
| Secondary CIDR Range           | `/20`                                 |
| Service CIDR Range             | `/24`                                 |
| Resources Not Used             | ❌ Vertex AI Workbench, Notebooks, Cloud SQL |

### 🟨 Scenario 1: Single Subnet for All Services

**Table 3: Scenario 1 - Single Subnet Allocation**

| Service            | CIDR Required | IP Address Count | CIDR Allocated              | Resources Consumed | Usage    | Concurrent Jobs |
|--------------------|---------------|------------------|-----------------------------|--------------------|----------|-----------------|
| Cloud Composer     | `/28`         | 16               |                             | Workflow management environment | 🟢 Light | 🔵 Low |
| Cloud Dataproc     | `/26`         | 64               | Single Shared Subnet (`/25`) | Hadoop/Spark clusters | 🔴 Heavy | 🔴 High |
| Cloud Dataflow     | `/28`         | 16               |                             | Data pipelines (streaming/batch) | 🟠 Medium | 🔴 High |
| **Total**          | **`/26 + 2×/28`** | **96**          | **`/25 (128 IP addresses)`**  |                    |          |                 |

**Pros:**
- ✅ Simple subnet management
- ✅ Efficient IP utilization
- ✅ Easier routing/firewall management
- ✅ Better scalability

**Cons:**
- ⚠️ Reduced service isolation
- ⚠️ Potential security concerns

### 🟪 Scenario 2: Separate Subnets for Each Service

**Table 4: Scenario 2 - Individual Subnet Allocation**

| Service            | CIDR Required | IP Address Count | CIDR Allocated (Individual) | Resources Consumed | Usage    | Concurrent Jobs |
|--------------------|---------------|------------------|-----------------------------|--------------------|----------|-----------------|
| Cloud Composer     | `/28`         | 16               | `/28`                       | Workflow management environment | 🟢 Light | 🔵 Low |
| Cloud Dataproc     | `/26`         | 64               | `/26`                       | Hadoop/Spark clusters | 🔴 Heavy | 🔴 High |
| Cloud Dataflow     | `/28`         | 16               | `/28`                       | Data pipelines (streaming/batch) | 🟠 Medium | 🔴 High |
| **Total**          |               | **96**           | **112 IP addresses (16 unused)** |                    |          |                 |

**Pros:**
- ✅ Enhanced security and isolation
- ✅ Easier troubleshooting
- ✅ Simplified compliance

**Cons:**
- ⚠️ Complex subnet management
- ⚠️ Inefficient IP utilization
- ⚠️ Higher administrative overhead
- ⚠️ Scalability limitations

## 🎯 Recommendation
**Recommended Scenario:** 🟨 **Scenario 1 (Single Subnet)**
- ✅ Efficient IP usage
- ✅ Simpler subnet management
- ✅ Scalable
- ✅ Balanced operational flexibility

