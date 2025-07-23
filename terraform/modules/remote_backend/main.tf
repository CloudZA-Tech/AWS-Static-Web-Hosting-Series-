# IAM User for Terraform
resource "aws_iam_user" "terraform_user" {
  name = var.iam_user_name
}

# Attach AdministratorAccess policy to the IAM user
resource "aws_iam_user_policy_attachment" "terraform_user_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  user       = aws_iam_user.terraform_user.name
}

# S3 Bucket for Terraform state
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "Terraform State Bucket"
  }
}

# Enable versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# S3 Bucket Policy
resource "aws_s3_bucket_policy" "terraform_state_policy" {
  bucket = aws_s3_bucket.terraform_state.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "s3:ListBucket",
        Resource = aws_s3_bucket.terraform_state.arn
        Principal = {
          AWS = aws_iam_user.terraform_user.arn
        }
      },
      {
        Effect   = "Allow",
        Action   = ["s3:GetObject", "s3:PutObject"],
        Resource = "${aws_s3_bucket.terraform_state.arn}/*",
        Principal = {
          AWS = aws_iam_user.terraform_user.arn
        }
      }
    ]
  })
}

# DynamoDB Table for state locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "Terraform State Lock Table"
  }
}