resource "google_compute_network" "custom_vpc" {
  name                    = "secure-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "serverless-subnet"
  ip_cidr_range = "10.8.0.0/28"
  region        = var.region
  network       = google_compute_network.custom_vpc.id
}

resource "google_vpc_access_connector" "connector" {
  name          = "serverless-connector"
  region        = var.region
  network       = google_compute_network.custom_vpc.id
  ip_cidr_range = "10.8.1.0/28"  # Different from subnet range

  min_instances = 2
  max_instances = 4
  
}

output "vpc_connector" {
  value = google_vpc_access_connector.connector.name
}
