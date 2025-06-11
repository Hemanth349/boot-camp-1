variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "project-2-458822"
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "alert_emails" {
  description = "List of email addresses for alerts"
  type        = list(string)
  default     = ["hemanthkumar.hk155@example.com"]
}
variable "build_sa_email" {
  description = "Service account email used by Cloud Build"
  type        = string
}

variable "vpc_sa_email" {
  description = "Service account email for the VPC connector (Cloud Run's service account)"
  type        = string
}

