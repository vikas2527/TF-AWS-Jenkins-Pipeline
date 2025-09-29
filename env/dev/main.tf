provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "../../modules/vpc"
  
  environment = var.environment
  name = var.name
  vpc_cidr = var.vpc_cidr
  azs = var.azs
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  enable_nat_gateway = var.enable_nat_gateway
  tags = var.tags 
}

