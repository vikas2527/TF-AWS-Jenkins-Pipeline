variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}
variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
}
variable "name" {
  description = "The name tag for the EC2 instance"
  type        = string
}
variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "key_name" {
  description = "The name of the key pair to use for the instance"
  type        = string
}
