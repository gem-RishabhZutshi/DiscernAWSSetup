resource "aws_iam_policy" "s3_access_policy" {
  name = "DiscrnUIAccessPolicy-${var.environment}"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action   = ["s3:ListBucket", "s3:GetObject"]
#         Effect   = "Allow"
#         Resource = [
#           "${var.s3_bucket_arn}",
#           "${var.s3_bucket_arn}/*"
#         ]
#       }
#     ]
#   })
# }

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:GetObject"]
        Effect   = "Allow"
        Resource = "${var.s3_bucket_arn}/${var.environment}/*"
        Principal = "*"
      }
    ]
  })
}


