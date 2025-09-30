resource "aws_instance" "qa-ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = merge(var.tags, { Name = "${var.name}-ec2" })
}

