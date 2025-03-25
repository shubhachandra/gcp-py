output "well_known_public_prefixes" {
  description = "List of well-known public IP prefixes"
  value = [
    "8.8.8.0/24",    # Google Public DNS
    "1.1.1.0/24",    # Cloudflare DNS
    "9.9.9.0/24",    # Quad9 DNS
    "208.67.222.0/24", # OpenDNS
    "198.51.100.0/24", # TEST-NET-2 (RFC 5737)
    "203.0.113.0/24"  # TEST-NET-3 (RFC 5737)
  ]
}

output "rfc1918_private_ranges" {
  description = "Private IP address ranges as per RFC 1918"
  value = [
    "10.0.0.0/8",     # Class A private network
    "172.16.0.0/12",  # Class B private network
    "192.168.0.0/16"  # Class C private network
  ]
}

output "rfc6598_carrier_grade_nat" {
  description = "Carrier-Grade NAT (CGNAT) IP range as per RFC 6598"
  value = [
    "100.64.0.0/10"  # CGNAT space
  ]
}

output "squat_space_ranges" {
  description = "Unallocated or squat space ranges often used internally"
  value = [
    "240.0.0.0/4",  # Reserved for future use (RFC 1112)
    "198.18.0.0/15", # Benchmarking (RFC 2544)
    "169.254.0.0/16" # Link-local (RFC 3927)
  ]
}

output "third_party_routes" {
  description = "Third-party assigned IP ranges"
  value = [
    "185.199.108.0/22", # GitHub Pages
    "104.16.0.0/12",    # Cloudflare
    "143.204.0.0/16"    # AWS CloudFront
  ]
}
