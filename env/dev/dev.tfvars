region = "us-east-1"
name = "dev-VPC"
vpc_cidr = "10.10.0.0/16"
public_subnet_cidrs = ["10.10.1.0/24","10.10.2.0/24"]
private_subnet_cidrs = ["10.10.101.0/24","10.10.102.0/24"]
enable_nat_gateway = true
tags = {
  Env = "dev"
  Owner = "devops"
}
