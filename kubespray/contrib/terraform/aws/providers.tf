terraform {
  backend "s3" {
    bucket         = "bucket-challenge"
    key            = "kubernetes/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "challenge-lock"
  }
}