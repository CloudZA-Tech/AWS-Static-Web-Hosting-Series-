output "acm_certificate_arn" {
  description = "The ARN of the ACM certificate"
  value       = aws_acm_certificate.cert.arn
}

output "zone_id" {
  description = "The Route53 zone ID"
  value       = data.aws_route53_zone.selected.zone_id
}