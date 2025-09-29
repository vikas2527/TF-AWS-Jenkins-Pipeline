resource "aws_vpc" "this_vpc" {
cidr_block = var.vpc_cidr
tags = merge(var.tags, { Name = var.name })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this_vpc.id
  tags   = merge(var.tags, { Name = "${var.name}-igw" })
}

# Public subnets
resource "aws_subnet" "public" {
  for_each = {for idx, cidr in var.public_subnet_cidrs : idx => cidr}
  vpc_id = aws_vpc.this_vpc.id
  cidr_block = each.value
  availability_zone = var.azs[each.key]
  map_public_ip_on_launch = true
  tags = merge(var.tags, { Name = "${var.name}-public-${each.key + 1}" })
}

# Private subnets
resource "aws_subnet" "private" {
  for_each = {for idx, cidr in var.private_subnet_cidrs : idx => cidr}
  vpc_id = aws_vpc.this_vpc.id
  cidr_block = each.value
  availability_zone = var.azs[each.key]
  map_public_ip_on_launch = false
  tags = merge(var.tags, { Name = "${var.name}-private-${each.key + 1}" })
}

# Public route table
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.this_vpc.id
    tags = merge(var.tags, { Name = "${var.name}-public-rt" })
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
  
}

resource "aws_route_table_association" "public" {
    for_each = aws_subnet.public
    subnet_id      = each.value.id
    route_table_id = aws_route_table.public.id
}

resource "aws_nat_gateway" "nat" {
    count = var.enable_nat_gateway ? length(aws_subnet.public) : 0
    allocation_id = aws_eip.nat[count.index].id
    subnet_id = element(aws_subnet.public.*.id, count.index)
    tags = merge(var.tags, { Name = "${var.name}-nat-${count.index + 1}" })
}

# Private route tables (one per AZ)
resource "aws_route_table" "private" {
    for_each = aws_subnet.private
    vpc_id = aws_vpc.this_vpc.id
    tags = merge(var.tags, { Name = "${var.name}-private-rt-${each.key + 1}" })  
  
}

resource "aws_route" "private_to_nat" {
    for_each = aws_route_table.private
    route_table_id = each.value.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = var.enable_nat_gateway ? element(aws_nat_gateway.nat.*.id, each.key) : null
    # If NAT disabled: this route won't be created (null isn't accepted) — but we've gated NAT
}

resource "aws_route_table_association" "private_assoc" {
  for_each = aws_subnet.private
  subnet_id = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}

# Basic default security group
resource "aws_security_group" "default" {
  name   = "${var.name}-default-sg"
  vpc_id = aws_vpc.this.id
  description = "Default security group"
  tags = var.tags

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "ssh (adjust)"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}