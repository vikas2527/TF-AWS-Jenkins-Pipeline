variable "environment" {
  description = "The name of the environment"
  type = string
  default = "dev"
}

variable "name" {
  description = "The name of the VPC"
  type = string
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "azs" {
  description = "The availability zones for the VPC"
  type        = list(string)
  default     = ["${var.aws_region}a", "${var.aws_region}b"]
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "the cidr blocks for the private subnets"
  type = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets"
  type        = bool
  default     = true
}

variable "tags" {
  type = map(string)
  default = {
    "owner" = "devops"
    "environment" = "Prod"
    "project" = "Terraform AWS Jenkins Pipeline"
  }
}