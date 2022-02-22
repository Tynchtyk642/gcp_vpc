provider "google-beta" {
  credentials = file(var.credentials_file_path)
  project = var.project_id
  region  = var.region
}

provider "google" {
  credentials = file(var.credentials_file_path)

  project = var.project_id
  region  = var.region
  zone    = var.main_zone
}

module "google_networks" {
  source = "./networks"

  nat_subnet_name = "application-subnet"

  #==========================SUBNETS=============================
  subnets = [
    {
      subnet_name     = "presentation-subnet"
      subnet_ip_range = var.presentation_ip_range
      subnet_region   = "us-central1"
      subnet_flow_logs = true
    },
    {
      subnet_name           = "application-subnet"
      subnet_ip_range       = var.application_ip_range
      subnet_region         = "us-central1"
      subnet_private_access = true
      subnet_flow_logs = true
    },
      ]


  #============================ROUTES=============================

  routes = [
    {
      name              = "igw-route"
      destination_range = var.igw_destination
      next_hop_internet = "true"
    },
  ]

  #=========================FIREWALL-RULES========================
  firewall_rules = [
    {
      name        = "presentation-firewall-rule"
      direction   = "INGRESS"
      ranges      = var.presentation_firewall_ranges
      target_tags = ["public"]
      source_tags = null
      target_service_accounts = null

      allow = [{
        protocol = "tcp"
        ports    = ["22"]
      }]
      deny = []
    },
    {
      name        = "application-firewall-rule"
      direction   = "INGRESS"
      ranges      = var.application_firewall_ranges
      target_tags = ["application"]
      source_tags = null
      target_service_accounts = null

      allow = [{
        protocol = "all"
        ports    = null
      }]
      deny = []
    },
    {
      name = "ingress-to-cluster"
      direction = "INGRESS"
      target_tags = null
      target_service_accounts = null
      source_tags = ["public"]
      ranges = null
      allow = [{
        protocol = "tcp"
        ports = ["22"]
      }]
      deny = []
    }
  ]
}