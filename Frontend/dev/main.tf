module "S3" {
  source = "./modules/S3"
  environment = Dev
  iam_policy_arn = module.IAM.iam_policy_arn
}

module "CloudFront" {
  source = "./modules/cloudfront"
  environment = Dev
  s3_bucket_id = module.S3.s3_bucket_id
}

module "IAM" {
  source = "./modules/IAM"
  environment = Dev
  s3_bucket_arn = module.S3.s3_bucket_arn
}