# provider block - what cloud platform do we want to access
provider "aws" {
  # which region to use
  region = "eu-west-1"
}

# which service/resource 
resource "aws_instance" "app_instance" {
  # ami to use 
  ami = var.app_ami-id

  # what type of instance to launch 
  instance_type = var.ec2_instance_type

  # do we need a public 

  associate_public_ip_address = var.bool_app_public_ip

  # name of the resource on aws 
  tags = {
    Name = var.app_instance_name
  }
}

