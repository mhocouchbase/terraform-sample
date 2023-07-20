# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "tf-sample-vpc"
  }
}
# Create Internet Gateway and Attach it to VPC
resource "aws_internet_gateway" "tf-sample-internet-gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "tf-sample-internet-gateway"
  }
}
# Create Public Subnet
resource "aws_subnet" "tf-sample-public-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "tf-sample-public-subnet"
  }
}

# Create Private Subnet
resource "aws_subnet" "tf-sample-private-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "tf-sample-private-subnet"
  }
}

# Create Route Table
resource "aws_route_table" "tf-sample-public-route-table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-sample-internet-gateway.id
  }
  tags = {
    Name = "tf-sample-public-route-table"
  }
}
# Associate Public Subnet to "Public Route Table"
resource "aws_route_table_association" "tf-sample-public-subnet-route-table-association" {
  subnet_id      = aws_subnet.tf-sample-public-subnet.id
  route_table_id = aws_route_table.tf-sample-public-route-table.id
}

# Create Security Group
resource "aws_security_group" "tf-sg-sample" {
  name        = "tf-sg-sample"
  description = "Enable ssh access"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    description     = "SSH Access"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "tf-sg-sample"
  }
}
