provider "aws" {
  version                 = "~> 2"
  region                  = var.region
  shared_credentials_file = var.shared_credentials_file
  profile                 = var.profile
}

terraform {
  backend "s3" {
    bucket         = "bucket-challenge"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "challenge-lock"
  }
}