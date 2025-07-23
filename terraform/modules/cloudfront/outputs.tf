output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = data.aws_cloudfront_distribution.existing.domain_name
}

output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = data.aws_cloudfront_distribution.existing.id
}