provider "google" {
  project = var.project_id
  region  = var.region
}




# 4. Service Account for Cloud Run
resource "google_service_account" "admin_app_sa" {
  account_id   = "admin-app-sa"
  display_name = "Admin App Service Account"
}

# 5. Cloud Run Service
resource "google_cloud_run_service" "admin_app" {
  name     = "admin-app"
  location = var.region

  template {
    metadata {
      annotations = {
        "run.googleapis.com/vpc-access-connector" = google_vpc_access_connector.serverless_connector.name
        "run.googleapis.com/vpc-access-egress"    = "private-ranges-only"  # safer than "all-traffic"

      }
    }

    spec {
      containers {
        image = "gcr.io/${var.project_id}/admin-app"
      }

      service_account_name = google_service_account.admin_app_sa.email
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# 6. IAM for invoking Cloud Run
resource "google_project_iam_member" "cloud_run_invoker" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.admin_app_sa.email}"
}
