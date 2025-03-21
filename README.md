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

---

## 📌 AIML Deployment & Inferencing Archetype Specification

**Table 5: Archetype Specification and Selected Tee Size**

| Archetype Name                 | AIML Deployment & Inferencing Archetype Specification |
|--------------------------------|------------------------------------------------------|
| Tee Size Selected              | 🟢 **Large (L)**                                      |
| Primary CIDR Range             | `/25 (128 IP addresses)`                             |
| Secondary CIDR Range           | `/20`                                                |
| Service CIDR Range             | `/24`                                                |
| Resources Used                 | ✅ Composer, Dataproc, Dataflow, Vertex AI Workbench, Notebooks |

---

## 📌 Advanced Analytics Archetype Specification

**Table 6: Archetype Specification and Selected Tee Size**

| Archetype Name                 | Advanced Analytics Archetype Specification |
|--------------------------------|-------------------------------------------|
| Tee Size Selected              | 🟢 **Small (S)**                           |
| Primary CIDR Range             | `/27 (32 IP addresses)`                    |
| Secondary CIDR Range           | `/22`                                     |
| Service CIDR Range             | `/26`                                     |
| Resources Used                 | ✅ Vertex AI Workbench, Notebooks          |
| Resources Not Used             | ❌ Composer, Dataproc, Dataflow, Cloud SQL |

---

## 📌 Business Intelligence Archetype Specification

**Table 7: Archetype Specification and Selected Tee Size**

| Archetype Name                 | Business Intelligence Archetype Specification |
|--------------------------------|----------------------------------------------|
| Tee Size Selected              | ❌ **No Subnet Required**                      |
| Resources Used                 | ✅ Non-compute resources (e.g., Looker, BigQuery) |
| Resources Not Used             | ❌ Composer, Dataproc, Dataflow, Vertex AI Workbench, Notebooks, Cloud SQL |

**Note:** This archetype does not require a subnet allocation as it does not utilize compute resources.

