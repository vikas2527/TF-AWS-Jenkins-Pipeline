variable "environment" {
  type = string
}

variable "name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type = list(string) 
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "enable_nat_gateway" {
  type = bool
}

variable "tags" {
  type = map(string)
}