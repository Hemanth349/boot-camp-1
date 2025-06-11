variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_connector" {
  type        = string
  description = "VPC connector name to attach to Cloud Run service"
  default     = null
}

variable "kms_key_id" {
  type        = string
  description = "KMS key resource ID for encrypting secrets"
  default     = null
}

variable "build_sa_email" {
  type        = string
  description = "Email of the build service account"
  default     = null
}