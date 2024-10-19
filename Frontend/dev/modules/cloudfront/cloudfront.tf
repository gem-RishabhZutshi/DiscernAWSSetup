resource "aws_cloudfront_distribution" "frontend_distribution" {
  origin {
    domain_name = "${var.s3_bucket_id}.s3.amazonaws.com"
    origin_id   = "${var.environment}-origin"
    origin_path = "/${var.environment}"  # Serve content from the environment folder
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.environment}-origin"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"   # "none" means no cookies are forwarded
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

   ordered_cache_behavior {
    path_pattern           = "/${var.environment}/*"
    target_origin_id       = "${var.environment}-origin"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }



  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name        = "CloudFront Distribution Dev"
    Environment = var.environment
  }
}


