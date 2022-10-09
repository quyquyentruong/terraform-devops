# tạo ssh keypair cho ec2 instance

resource "aws_key_pair" "devops" {
  key_name = "quyentq-devops-ssh"

  # replace the below with your public key
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCyxIF8ZyY3JZ4BatU/b8/rqaDMXDTTNJfgFjTdzjWVPi7klPYe8Zp/Yb9R2ix7f3pbzsldgy+jCJtCXV1xIQLezJNbR2eao3c78eG9Px1wvNtqlbe2Cgsj/i4FG19Pc2T0xOk5n35EqkMZDlbZHEnqd/pZcPW7bTa10J/Mg6S3GaYjlL5JZnI4dh7AstiQmc9S+uEP8EDy6oth/I98QDicss20GRV91/mKCpw8nAExyl8UfcMf47a4/6tVLfzlovzxM8yii/Q8BmrxvlAqj+ddMyIi/zxkZtuWl+7RuQCmprVNJSSZdlj2PtNiHK6Q0Ho7X/iPFEvIN2SQrVUSZcdD thanhhoang@beeketing.net"
}

module "ec2_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "web-security-group-${var.env}"
  description = "Security group for Web ec2 instances"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp", "ssh-tcp"]
  egress_rules        = ["all-all"]
}


# tạo ec2 instance

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "web-instance-${var.env}"

  ami                    = "ami-0eaf04122a1ae7b3b" # https://cloud-images.ubuntu.com/locator/ec2/
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.devops.key_name
  vpc_security_group_ids = [module.ec2_security_group.security_group_id]
  subnet_id              = element(module.vpc.public_subnets, 0)

  tags = {
    Terraform   = "true"
    Environment = "${var.env}"
  }
}