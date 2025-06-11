variable "project_id" {
  type = string
}

variable "region" {
  type = string
}
variable "build_sa_email" {
  type        = string
  description = "Build service account email"
  default     = null
}

variable "kms_key_id" {
  type        = string
  description = "KMS key ID for encryption"
  default     = null
}
variable "vpc_sa_email" {
  description = "Service account email for the VPC connector (Cloud Run's service account)"
  type        = string
}