# provider block - what cloud platform do we want to access
provider "aws" {
  # which region to use
  region = var.region
}

# create a VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr # overall IP range for the VPC

  tags = {
    Name = "hmlr-aaron-vpc-tf"
  }
}

# Public Subnet 
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  ipv6_cidr_block         = null

  tags = {
    Name = "public-subnet"
  }
}

# Private subnet 

resource "aws_subnet" "private_subnet" {
  vpc_id          = aws_vpc.main_vpc.id
  cidr_block      = var.private_subnet_cidr
  ipv6_cidr_block = null

  tags = {
    Name = "private-subnet"
  }
}

# Internet Gateway 

resource "aws_internet_gateway" "main_gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "hmlr-aaron-vpc-ig-tf"
  }
}

# Route Table for public subnet 

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  # Default route to ig
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gw.id
  }


  tags = {
    Name = "hmlr-aaron-vpc-public-rt-tf"
  }
}

# Associate the public subnet with the public route table 
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

