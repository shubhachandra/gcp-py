subnetwork_api = [
  for key in keys(var.api) : var.api[key]
  if contains(var.active_api, key)
]
