data "google_cloud_identity_group" "subnetwork_group" {
  group_email = var.group_email
}

resource "google_cloud_identity_group_membership" "example_member" {
  group = data.google_cloud_identity_group.subnetwork_group.name

  preferred_member_key {
    id = "serviceAccount:my-service-account@my-project.iam.gserviceaccount.com"  # Replace with actual member
  }

  roles {
    name = "MEMBER"
  }
}

resource "google_cloud_identity_group_membership" "example" {
  group = "groups/your-group-id" # Replace with your group resource name

  preferred_member_key {
    id = format("serviceAccount:%s@cloudservices.gserviceaccount.com", local.service_project_number)
  }

  roles {
    name = "MEMBER"
  }
}
