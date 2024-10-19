output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.frontend_distribution.id
}

output "cloudfront_distribution_domain" {
  value = aws_cloudfront_distribution.frontend_distribution.domain_name
}