resource "google_kms_key_ring" "keyring" {
  name     = "run-keyring"
  location = var.region
}

resource "google_kms_crypto_key" "crypto_key" {
  name            = "run-key"
  key_ring        = google_kms_key_ring.keyring.id
  rotation_period = "2592000s"
}

output "kms_key_id" {
  value = google_kms_crypto_key.crypto_key.id
}