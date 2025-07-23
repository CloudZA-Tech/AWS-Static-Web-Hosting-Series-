variable "iam_user_name" {
  description = "Name of the IAM user for Terraform"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
}

variable "table_name" {
  description = "Name of the DynamoDB table for Terraform locks"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}