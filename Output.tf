 https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=32555940559.apps.googleusercontent.com&redirect_uri=http%3A%2F%2Flocalhost%3A8085%2F&scope=openid+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcloud-platform+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fappengine.admin+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fsqlservice.login+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcompute+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Faccounts.reauth&state=3pOEOu0UT4oWaiv2zZcUkNLGVHJUCD&access_type=offline&code_challenge=KAtXaQGLPJgARVzloF2xrf8c2of2euut-mZ-yoc4Vp8&code_challenge_method=S256
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

resource "google_cloud_identity_group_membership" "example_member" {
  group = data.google_cloud_identity_group.subnetwork_group.name

  preferred_member_key {
    id = "serviceAccount:service-${module.project_factory_project.project_number}@dataproc-accounts.iam.gserviceaccount.com"
  }

  roles {
    name = "MEMBER"
  }
}
