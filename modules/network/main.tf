resource "aws_vpc" "customvpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.customvpc.id
  cidr_block = var.public_subnet_cidr
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet1"
  }
}
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.customvpc.id
  cidr_block = var.private_subnet_cidr
  availability_zone = var.availability_zone
  tags = {
    Name = "private_subnet1"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.customvpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_eip" "nat_eip" {}

resource "aws_nat_gateway" "net_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.private_subnet.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "public_subnet-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public_subnet_rt"
  }
}

resource "aws_route_table" "private_subnet_subnet-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.net_gw.id
  }

  tags = {
    Name = "private_subnet_rt"
  }
}

resource "aws_route_table_association" "public_subnet_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_subnet-rt.id
}

resource "aws_route_table_association" "private_subnet_rt_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.public_subnet-rt.id
}