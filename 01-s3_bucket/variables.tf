variable "region" {
  type        = string
  description = "AWS Region"
  default     = "eu-west-1"
}

variable "shared_credentials_file" {
  type        = string
  description = "AWS Profile"
  default     = "~/.aws/credentials"
}

variable "profile" {
  type        = string
  default     = "default"
  description = "Profile"
}