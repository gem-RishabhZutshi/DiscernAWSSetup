resource "aws_s3_bucket" "frontend_bucket" {
  bucket = "discern-uii-${var.environment}"

  tags = {
    Name        = "Discern-UI S3 Bucket"
    Environment = var.environment
  }
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


