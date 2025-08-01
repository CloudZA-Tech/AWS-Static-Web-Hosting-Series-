output "bucket_name" {
  description = "The name of the S3 bucket for Terraform state"
  value       = aws_s3_bucket.terraform_state.bucket
}

output "table_name" {
  description = "The name of the DynamoDB table for Terraform locks"
  value       = aws_dynamodb_table.terraform_locks.name
}