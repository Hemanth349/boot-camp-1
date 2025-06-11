data "google_project" "project" {}

resource "google_project_iam_member" "kms_encrypter" {
  project = var.project_id
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member  = "serviceAccount:service-${data.google_project.project.number}@serverless-robot-prod.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "vpc_user" {
  project = var.project_id
  role    = "roles/compute.networkUser"
  member  = "serviceAccount:${var.vpc_sa_email}"
}

resource "google_kms_crypto_key_iam_member" "key_usage" {
  crypto_key_id = var.kms_key_id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${var.build_sa_email}"
}
