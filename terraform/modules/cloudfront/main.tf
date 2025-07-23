resource "aws_cloudfront_origin_access_control" "oac" {
    name                              = "${var.bucket_name}-oac"
    description                       = "Origin Access Control for ${var.bucket_name}"
    origin_access_control_origin_type = "s3"
    signing_behavior                  = "always"
    signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "website_distribution" {
    enabled             = true
    is_ipv6_enabled     = true
    default_root_object = "index.html"
    aliases             = [var.domain_name, "www.${var.domain_name}"]
    # Use existing CloudFront distribution if available
    count               = 0 # Set to 0 to use existing distribution
    
    # Uncomment and use this if you want to create a new distribution
    # enabled             = true
    # is_ipv6_enabled     = true
    # default_root_object = "index.html"
    # aliases             = [var.domain_name, "www.${var.domain_name}"]
    
    origin {
        domain_name = var.bucket_regional_domain_name
        origin_id   = var.bucket_name
        origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
    }

    default_cache_behavior {
        allowed_methods  = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        # Using AWS Managed-CachingOptimized cache policy
        cache_policy_id  = "658327ea-f89d-4fab-a63d-7e88639e58f6"
        target_origin_id = var.bucket_name
        viewer_protocol_policy = "redirect-to-https"
    } 

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    viewer_certificate {
        acm_certificate_arn = var.acm_certificate_arn
        ssl_support_method  = "sni-only"
        minimum_protocol_version = "TLSv1.2_2021"
    }
}

resource "aws_s3_bucket_policy" "cloudfront_bucket_policy" {
  bucket = var.bucket_name

  policy = jsonencode({
    Version = "2008-10-17"
    Id      = "PolicyForCloudFrontPrivateContent"
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipal"
        Effect    = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "arn:aws:s3:::${var.bucket_name}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.website_distribution.arn
          }
        }
      }
    ]
  })
}

resource "aws_route53_record" "website_domain" {
    zone_id = var.zone_id
    name    = var.domain_name
    type    = "A"

    alias {
        name                   = aws_cloudfront_distribution.website_distribution.domain_name
        zone_id                = aws_cloudfront_distribution.website_distribution.hosted_zone_id
        evaluate_target_health = false
    }
}

resource "aws_route53_record" "www_domain" {
    zone_id = var.zone_id
    name    = "www.${var.domain_name}"
    type    = "A"

    alias {
        name                   = aws_cloudfront_distribution.website_distribution.domain_name
        zone_id                = aws_cloudfront_distribution.website_distribution.hosted_zone_id
        evaluate_target_health = false
    }
}