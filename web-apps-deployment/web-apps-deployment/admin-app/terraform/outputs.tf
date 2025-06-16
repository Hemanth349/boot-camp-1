output "admin_app_url" {
  value = google_cloud_run_service.admin_app.status[0].url
}
