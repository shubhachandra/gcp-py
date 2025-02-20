import subprocess
import json
import pandas as pd

# Function to get a list of all projects
def get_projects():
    print("Fetching list of projects...")
    result = subprocess.run(["gcloud", "projects", "list", "--format=json"], capture_output=True, text=True)
    projects = json.loads(result.stdout)
    return [proj["projectId"] for proj in projects]

# Function to get subnet creation logs for a given project
def get_subnet_creation_logs(project_id):
    print(f"Fetching logs for project: {project_id}...")
    command = [
        "gcloud", "logging", "read",
        'protoPayload.methodName="v1.compute.subnetworks.insert"',
        "--project", project_id,
        "--format=json"
    ]
    result = subprocess.run(command, capture_output=True, text=True)

    if result.stdout.strip():
        return json.loads(result.stdout)
    return []

# Main function
def main():
    projects = get_projects()
    logs = []

    for project in projects:
        project_logs = get_subnet_creation_logs(project)
        for log in project_logs:
            logs.append({
                "timestamp": log.get("timestamp", ""),
                "project": project,
                "actor_email": log.get("protoPayload", {}).get("authenticationInfo", {}).get("principalEmail", ""),
                "resource_name": log.get("protoPayload", {}).get("resourceName", "")
            })

    # Convert logs to CSV
    if logs:
        df = pd.DataFrame(logs)
        df.to_csv("subnet_creation_logs.csv", index=False)
        print("✅ Logs saved to subnet_creation_logs.csv")
    else:
        print("❌ No subnet creation logs found.")

if __name__ == "__main__":
    main()
