provider "aws" {
  version                 = "~> 2"
  region                  = var.region
  shared_credentials_file = var.shared_credentials_file
  profile                 = var.profile
}