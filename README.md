| Tee Size       | Primary Range | Secondary Range | Service Range |
|----------------|---------------|-----------------|---------------|
| Micro-XS       | /28           | /23             | /27           |
| Small-S        | /27           | /22             | /26           |
| Medium-M       | /26           | /21             | /25           |
| Large-L        | /25           | /20             | /24           |
| Extra Large-XL | /24           | /19             | /18           |

| Archetype Name                 | Data Pipeline Archetype Specification |
|--------------------------------|---------------------------------------|
| Tee Size Selected              | Large (L)                             |
| Primary CIDR Range             | /25 (128 IP addresses)                |
| Secondary CIDR Range           | /20                                   |
| Service CIDR Range             | /24                                   |

| Scenario | Service            | CIDR Required | IP Address Count | CIDR Allocated              |
|----------|--------------------|---------------|------------------|-----------------------------|
| 1        | Cloud Composer     | /28           | 16               |                             |
| 1        | Cloud Dataproc     | /26           | 64               | Single Shared Subnet (/25)  |
| 1        | Cloud Dataflow     | /28           | 16               |                             |
| 1        | Total              | /26 + 2×/28   | 96               | /25 (128 IP addresses)      |

Pros Scenario 1:
- Simpler subnet management.
- Efficient IP address utilization.
- Easier routing and firewall management.
- Better scalability.

Cons Scenario 1:
- Reduced service isolation.
- Potential security concerns.

| Scenario | Service            | CIDR Required | IP Address Count | CIDR Allocated (Individual) |
|----------|--------------------|---------------|------------------|-----------------------------|
| 2        | Cloud Composer     | /28           | 16               | /28                         |
| 2        | Cloud Dataproc     | /26           | 64               | /26                         |
| 2        | Cloud Dataflow     | /28           | 16               | /28                         |
| 2        | Total              |               | 96               | 112 IP addresses (16 unused) |

Pros Scenario 2:
- Enhanced security and isolation.
- Easier troubleshooting.
- Compliance simplicity.

Cons Scenario 2:
- Complex subnet management.
- Inefficient IP address utilization.
- Higher administrative overhead.
- Potential scalability limitations.

Recommended Scenario: Scenario 1 (Single Subnet)
- Efficient, simpler management, scalable, balanced operational flexibility.

