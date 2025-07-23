variable "domain_name" {
  description = "Domain name for the website"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket for website hosting"
  type        = string
}

variable "bucket_regional_domain_name" {
  description = "The regional domain name of the S3 bucket"
  type        = string
}

variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate"
  type        = string
}

variable "zone_id" {
  description = "The Route53 zone ID"
  type        = string
}