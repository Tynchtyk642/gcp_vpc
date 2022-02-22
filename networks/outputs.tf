output "vpc_id" {
  description = "VPC ID"
  value = google_compute_network.vpc.id
}

output "subnet_name" {
  description = "Created subnets name."
  value = [for subnet in google_compute_subnetwork.subnets : subnet.name]
}

# output "subnet_region" {
#   value = [for subnet in google_compute_subnetwork.subnets : subnet.region]
# }


