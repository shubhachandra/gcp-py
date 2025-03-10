Subject: Cloud Resource Usage & Best Practices Questionnaire

Dear Team,

As part of our efforts to optimize cloud resource allocation and ensure best practices, we request your input on the resources you use, workload sizes, and recommendations for worker nodes. Your responses will help us fine-tune configurations, enhance cost efficiency, and align with best practices.

Please take a few minutes to complete the following questionnaire:

| **Resource**                           | **Used? (Yes/No)** | **Details/Explanation**                                                  | **Best Practices (Optional - Text or Link)** | **Recommended Worker Size (Provide Your Own Suggestion Based on Experience or Google Documentation)** |
|----------------------------------------|-------------------|--------------------------------------------------------------------------|----------------------------------------------|--------------------------------------------------------------|
| **Resources that Need a Subnet**       |                   |                                                                          |                                              |                                                              |
| **Compute and Processing Services**    |                   |                                                                          |                                              |                                                              |
| Cloud Composer                         |                   | Managed workflow orchestration; requires a private IP for secure access. |                                              | N/A                                                          |
| Cloud Dataproc                         |                   | Hadoop and Spark cluster processing; requires subnet setup.              |                                              | Varies based on workload                                     |
| **Data Processing Services**           |                   |                                                                          |                                              |                                                              |
| Cloud Dataflow - Batch Jobs            |                   | Used for large-scale data processing. Define expected data size.         |                                              |                                                              |
|                                        |                   | **Size of Data Handled (TB) (Provide Your Own Definition):**             |                                              |                                                              |
|                                        |                   | Extra Small (XS): < ? TB                                                 |                                              | 1-2 workers                                                  |
|                                        |                   | Small (S): ? TB - ? TB                                                   |                                              |                                                              |
|                                        |                   | Medium (M): ? TB - ? TB                                                  |                                              |                                                              |
|                                        |                   | Large (L): ? TB - ? TB                                                   |                                              |                                                              |
|                                        |                   | Extra Large (XL): > ? TB                                                 |                                              |                                                              |
| Cloud Dataflow - Stream Jobs           |                   | Processes streaming data in real-time. Define concurrent job capacity.   |                                              |                                                              |
|                                        |                   | **Concurrent Jobs (Select Range):**                                      |                                              |                                                              |
|                                        |                   | 1-5                                                                      |                                              |                                                              |
|                                        |                   | 6-10                                                                     |                                              |                                                              |
|                                        |                   | 11-20                                                                    |                                              |                                                              |
|                                        |                   | 21+                                                                      |                                              |                                                              |
| **AI and Database Services**           |                   |                                                                          |                                              |                                                              |
| Vertex AI Workbench                    |                   | Used for ML model training and testing; requires private networking.     |                                              | Varies based on workload                                     |
| Cloud SQL Instances                    |                   | Managed relational database service; may require private IP.             |                                              | Varies based on workload                                     |
| **Resources that Don’t Need a Subnet** |                   |                                                                          |                                              |                                                              |
| **Storage and Analytics Services**     |                   |                                                                          |                                              |                                                              |
| BigQuery                               |                   | Serverless data warehouse for analytics. No subnet required.             |                                              | N/A                                                          |
| Cloud Storage Bucket                   |                   | Object storage for data, files, and backups. No subnet required.         |                                              | N/A                                                          |

Additional Questions
Are there any additional resources you use that are not listed above? (Open-ended)
Do you plan to scale any of these resources in the next 6-12 months? (Yes/No, if Yes, specify)
Do you use private networking for any of these resources? (Yes/No, if Yes, specify)
How frequently do you process large datasets? (Daily, Weekly, Monthly, Ad-hoc)
Do you use auto-scaling for any of these resources? (Yes/No, if Yes, specify)
Do you use preemptible or spot instances for cost optimization? (Yes/No, if Yes, specify which workloads)
Would you like to receive recommendations on right-sizing your compute instances based on actual usage data? (Yes/No)
Would you like to share any best practices for optimizing cloud resources? (Optional text field or link)
Are there any specific Google Cloud documentation links you refer to frequently? (Optional text field or link)
