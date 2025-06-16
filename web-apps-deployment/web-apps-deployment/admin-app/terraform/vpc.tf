resource "google_compute_network" "vpc_network" {
  name                    = "admin-app-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "admin-app-subnet"
  ip_cidr_range = "10.10.0.0/16"
  network       = google_compute_network.vpc_network.id
  region        = var.region
}

resource "google_vpc_access_connector" "serverless_connector" {
  name          = "admin-app-connector-2"
  project       = var.project_id
  region        = var.region
  network       = google_compute_network.vpc_network.name
  ip_cidr_range = "10.8.1.0/28"

 min_instances = 2
 max_instances = 5 
}
