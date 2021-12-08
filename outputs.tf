output "vpc_id" {
  description = "VPC ID."
  value = module.google_networks.vpc_name
}
output "subnet" {
  description = "Subnets name"
  value = module.google_networks.subnet_name
}


