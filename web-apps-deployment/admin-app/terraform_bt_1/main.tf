provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source     = "./vpc"
  project_id = var.project_id
  region     = var.region
}

module "kms" {
  source     = "./kms"
  project_id = var.project_id
  region     = var.region
}

module "iam" {
  source = "./iam"

  project_id     = var.project_id
  region         = var.region
  build_sa_email = var.build_sa_email
  vpc_sa_email   = var.vpc_sa_email
  kms_key_id     = module.kms.kms_key_id # or the correct reference to your KMS key
}

module "cloudrun" {
  source         = "./cloudrun"
  project_id     = var.project_id
  region         = var.region
  vpc_connector  = module.vpc.vpc_connector
  kms_key_id     = module.kms.kms_key_id
  build_sa_email = var.build_sa_email
}

