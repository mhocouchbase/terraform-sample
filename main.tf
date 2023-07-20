provider "aws" {
  region     = "us-east-1"
  
  
}

#EC2 launch configuration
resource "aws_instance" "ec2_public" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  security_groups             = ["${aws_security_group.tf-sg-sample.id}"]
  subnet_id                   = aws_subnet.tf-sample-public-subnet.id
  associate_public_ip_address = true
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    "Name" = "tf-sample-public"
  }
  
 
}
#EC2 launch configuration
resource "aws_instance" "ec2_private" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  security_groups             = ["${aws_security_group.tf-sg-sample.id}"]
  subnet_id                   = aws_subnet.tf-sample-private-subnet.id
  associate_public_ip_address = false
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    "Name" = "tf-sample-private"
  }
 
}
