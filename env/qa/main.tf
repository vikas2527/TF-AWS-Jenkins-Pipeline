provider "aws" {
  region = var.region
}

module "ec2" {
  source = "../../modules/ec2"
  
  ami_id = var.ami_id
  instance_type = var.instance_type
  name = var.name
  tags = var.tags
  region = var.region
  key_name = var.key_name
}