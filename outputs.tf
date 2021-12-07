output "vpc_id" {
  value = module.google_networks.vpc_name
}
output "subnet" {
  value = module.google_networks.subnet_name
}


