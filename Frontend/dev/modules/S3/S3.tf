resource "aws_s3_bucket" "frontend_bucket" {
  bucket = "discern-uii-${var.environment}"

  tags = {
    Name        = "Discern-UI S3 Bucket"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "frontend_bucket_public_access_block" {
  bucket = aws_s3_bucket.frontend_bucket.id
  block_public_acls   = false
  block_public_policy = false
  ignore_public_acls   = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "frontend_bucket_policy" {
  bucket = aws_s3_bucket.frontend_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:GetObject"]
        Effect   = "Allow"
        Resource = "${aws_s3_bucket.frontend_bucket.arn}/${var.environment}/*"
        Principal = "*"
      }
    ]
  })
}


