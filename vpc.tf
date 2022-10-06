resource "aws_vpc" "test-terraform" {
  cidr_block       = "10.9.0.0/16"

  tags = {
    Name = "devops-vpc-quyentq"
  }
}