resource "aws_s3_bucket" "frontend_bucket" {
  bucket = "Discern-UI-${var.environment}"

  tags = {
    Name        = "Discern-UI S3 Bucket"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_policy" "frontend_bucket_policy" {
  bucket = aws_s3_bucket.frontend_bucket.id
  policy = var.iam_policy_arn
}


