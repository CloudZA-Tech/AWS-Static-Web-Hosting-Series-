output "website_endpoint" {
  description = "The S3 website endpoint"
  value       = module.s3_website.website_endpoint
}

output "cloudfront_domain_name" {
  description = "The CloudFront distribution domain name"
  value       = module.cloudfront.cloudfront_domain_name
}

output "website_url" {
  description = "The website URL"
  value       = "https://${var.domain_name}"
}