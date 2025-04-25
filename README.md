subnetwork_api = [
  for key in keys(var.api) : var.api[key]
  if contains(var.active_api, key)
]

https://github.com/terraform-google-modules/terraform-google-project-factory/issues/987
