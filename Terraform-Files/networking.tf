# Locals give you the use this tags on all resource
locals {
  common_tags = {
    ManagedBy   = "Terraform"
    Project     = "Task1"
    CostCernter = "1234"
  }
}

# Create VPC resource name main
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = merge(local.common_tags, {
    Name = "Tasks1-vpc"
  })
}

# Create subnet resource name public
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = merge(local.common_tags, {
    Name = "Tasks1-subnet-public"
  })
}

# Create subnet resource name private
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = merge(local.common_tags, {
    Name = "Tasks1-subnet-private"
  })
}

# Create new internet gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "Tasks1-IGW"
  })
}

# Create the public route table - the default route to IGW make this public
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = merge(local.common_tags, {
    Name = "Tasks1-RouteTable-Public"
  })
}

# Create the private route table - the default route to IGW make this private
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = merge(local.common_tags, {
    Name = "Tasks1-RouteTable-Private"
  })
}

# Associate the Subnet public & Route-Table public together
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Associate the Subnet private & Route-Table private together
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
