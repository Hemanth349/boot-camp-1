resource "google_cloud_run_v2_service" "admin_app" {
  name     = "admin-app"
  location = var.region

  deletion_protection = false

  template {
    containers {
      image = "gcr.io/project-2-458822/web-apps-deployment/admin-app"
    }
    service_account = var.build_sa_email
    vpc_access {
      connector = "projects/project-2-458822/locations/us-central1/connectors/serverless-connector"
      egress    = "ALL_TRAFFIC"
    }
    encryption_key = var.kms_key_id
  }
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.60.0"
    }
  }
}