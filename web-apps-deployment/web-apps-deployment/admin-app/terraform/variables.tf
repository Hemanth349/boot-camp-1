variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "project-2-458822"
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}
variable "admin_service_account_email" {
  description = "The email of the admin service account"
  type        = string
  default     = "hemanth-861@project-2-458822.iam.gserviceaccount.com"
}
variable "cloud_function_service_account_email" {
  description = "The email of the cloud function service account"
  type        = string
  default     = "project-2-458822@appspot.gserviceaccount.com"
}


