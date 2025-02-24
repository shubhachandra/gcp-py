resource.type=("gce_instance" OR "container" OR "load_balancer" OR "cloud_sql_database" OR "redis_instance" OR "bigtable_cluster")
jsonPayload.networkInterfaces[0].networkIP:*

resource "time_offset" "destroy_after_3_months" {
  offset_days = 90
}

resource "null_resource" "trigger_destroy" {
  triggers = {
    destroy_time = time_offset.destroy_after_3_months.rfc3339
  }

  provisioner "local-exec" {
    when    = destroy
    command = "terraform destroy -target=google_compute_subnetwork.my_subnet -auto-approve"
  }
}

We need to create a dashboard for IP demarcation if an IPAM system is not available. The dashboard should display commonly used IP ranges, highlight ranges that are nearly exhausted with color coding, automatically update subnet provisioning data after the Excel sheet is refreshed, and show the available reserved IPs for each block.
