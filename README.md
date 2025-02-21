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
