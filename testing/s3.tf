module "s3_b" {
  source = "../modules/s3"

  bucket_name = "quyentq3-test-module-terraform"

  tags = {
    Env = "testing"
  }
}