resource "aws_cloudfront_origin_access_control" "oac" {
    name                              = "${var.bucket_name}-oac"
    description                       = "Origin Access Control for ${var.bucket_name}"
    origin_access_control_origin_type = "s3"
    signing_behavior                  = "always"
    signing_protocol                  = "sigv4"
}

# Use data source to reference existing CloudFront distribution
data "aws_cloudfront_distribution" "existing" {
  id = "E1ZN3HIGD83NPO"
}

# Empty resource to maintain references in the code
resource "aws_cloudfront_distribution" "website_distribution" {
    count = 0
    enabled = true
    default_root_object = "index.html"
    
    origin {
        domain_name = "example.com"
        origin_id   = "example"
    }
    
    default_cache_behavior {
        allowed_methods  = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = "example"
        viewer_protocol_policy = "redirect-to-https"
        
        forwarded_values {
            query_string = false
            cookies {
                forward = "none"
            }
        }
    }
    
    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }
    
    viewer_certificate {
        cloudfront_default_certificate = true
    }
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
          ArnLike = {
            "AWS:SourceArn" = "arn:aws:cloudfront::459573696753:distribution/E1ZN3HIGD83NPO"
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
        name                   = data.aws_cloudfront_distribution.existing.domain_name
        zone_id                = data.aws_cloudfront_distribution.existing.hosted_zone_id
        evaluate_target_health = false
    }
}

resource "aws_route53_record" "www_domain" {
    zone_id = var.zone_id
    name    = "www.${var.domain_name}"
    type    = "A"

    alias {
        name                   = data.aws_cloudfront_distribution.existing.domain_name
        zone_id                = data.aws_cloudfront_distribution.existing.hosted_zone_id
        evaluate_target_health = false
    }
}