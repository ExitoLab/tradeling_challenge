resource "aws_s3_bucket" "bucket-challenge" {
  bucket        = "bucket-challenge"
  acl           = "private"
  force_destroy = true

  tags = {
    Name = "S3 Remote Terraform State Store"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket-challenge-policy" {
  bucket                  = aws_s3_bucket.bucket-challenge.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "challenge-terraform-locks" {
  name         = "challenge-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}