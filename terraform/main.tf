terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-static-website"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

# Remote Backend Module
module "remote_backend" {
  source = "./modules/remote_backend"

  iam_user_name = var.iam_user_name
  bucket_name   = var.bucket_name
  table_name    = var.table_name
  region        = var.region
}

# Route53 and ACM Module
module "route53_acm" {
  source = "./modules/route53_acm"

  domain_name = var.domain_name
  region      = var.region
}

# S3 Website Module
module "s3_website" {
  source = "./modules/s3_website"

  bucket_name = var.website_bucket_name
  domain_name = var.domain_name
}

# CloudFront Module
module "cloudfront" {
  source = "./modules/cloudfront"

  domain_name         = var.domain_name
  bucket_name         = module.s3_website.bucket_name
  bucket_regional_domain_name = module.s3_website.bucket_regional_domain_name
  acm_certificate_arn = module.route53_acm.acm_certificate_arn
  zone_id             = module.route53_acm.zone_id
}