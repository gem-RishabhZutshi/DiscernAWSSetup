# Define the VPC
resource "aws_vpc" "discern_dev_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "Discern-VPC"
  }
}

# Define the internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.discern_dev_vpc.id

  tags = {
    Name = "Discern-VPC-igw"
  }
}

# Define two public subnets in different availability zones
resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.discern_dev_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"

  map_public_ip_on_launch = true

  tags = {
    Name = "Discern-public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id     = aws_vpc.discern_dev_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1b"

  map_public_ip_on_launch = true

  tags = {
    Name = "Discern-public-subnet-2"
  }
}

# Create a route table for public subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.discern_dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "Discern-public-route-table"
  }
}

# Associate public subnets with the route table
resource "aws_route_table_association" "public_subnet1_association" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet2_association" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}

