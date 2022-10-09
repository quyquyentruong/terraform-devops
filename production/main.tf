terraform {
  backend "s3" {
    bucket = "s3-bucket-terraform-quyentq3"
    key    = "production/terraform.tfstate"
    region = "ap-southeast-1"
    dynamodb_table = "terraform-quyentq3-tech-master-course"
  }
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.33.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}