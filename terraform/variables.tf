variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "iam_user_name" {
  description = "Name of the IAM user for Terraform"
  type        = string
  default     = "terraform-user"
}

variable "bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
  default     = "terraform-state-static-website"
}

variable "table_name" {
  description = "Name of the DynamoDB table for Terraform locks"
  type        = string
  default     = "terraform-locks"
}

variable "domain_name" {
  description = "Domain name for the website"
  type        = string
  default     = "example.com"
}

variable "website_bucket_name" {
  description = "Name of the S3 bucket for website hosting"
  type        = string
  default     = "example-website-bucket"
}