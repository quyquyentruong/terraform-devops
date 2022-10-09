module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = "quyentq-product-devops-vpc"
  cidr = "10.9.0.0/16"

  azs              = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  public_subnets   = ["10.9.1.0/24", "10.9.2.0/24", "10.9.3.0/24"]
  private_subnets  = ["10.9.101.0/24", "10.9.102.0/24", "10.9.103.0/24"]

  tags = {
    Terraform = "true"
    Environment = "product"
  }
}