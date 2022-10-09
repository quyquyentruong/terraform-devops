module "s3_b" {
  source = "../modules/s3"

  bucket_name = "quyentq3-production-module-terraform"

  tags = {
    Env = "production"
  }
}