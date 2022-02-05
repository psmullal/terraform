terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "adm" {
  count         = var.num_instances
  ami           = "ami-0a8b4cd432b1c3063"
  instance_type = "t2.micro"
  network_interface {
    network_interface_id = aws_network_interface.ten_one[count.index].id
    device_index         = 0
  }
  tags = {
    Name = "adm${format("%02d", count.index + 1)}.${var.domain}"
  }
}

resource "aws_route53_record" "adm" {
  // same number of records as instances
  count   = var.num_instances
  zone_id = var.aws_route53_zone
  name    = "adm${format("%02d", count.index + 1)}"
  type    = "A"
  ttl     = "300"
  // matches up record N to instance N
  records = ["${element(aws_instance.adm.*.private_ip, count.index)}"]
}
resource "aws_db_instance" "basicdb" {
  allocated_storage    = 5
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "basicdb"
  username             = "dbadmin"
  password             = "gp4CT0*^1vyX9AF"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}
resource "aws_route53_record" "www" {
  // same number of records as instances
  count   = var.num_instances
  zone_id = var.aws_route53_zone
  name    = "www${format("%02d", count.index + 1)}"
  type    = "A"
  ttl     = "300"
  // matches up record N to instance N
  records = ["${element(aws_instance.www.*.private_ip, count.index)}"]
}
# VPC First
resource "aws_vpc" "firstvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    "Name" = "first_vpc"
  }
}

# Create a Subnet for the VPC
resource "aws_subnet" "ten_zero" {
  vpc_id     = aws_vpc.firstvpc.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "10.0.0.0 Private Subnet"
  }
}

resource "aws_subnet" "ten_one" {
  vpc_id     = aws_vpc.firstvpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "10.0.1.0 Private Subnet"
  }
}

# Create the Instance Network Interfaces
resource "aws_network_interface" "ten_zero" {
  count     = var.num_instances
  subnet_id = aws_subnet.ten_zero.id
  tags = {
    Name = "10.0.0.0 Private Network Interface"
  }
}

resource "aws_network_interface" "ten_one" {
  count     = var.num_instances
  subnet_id = aws_subnet.ten_one.id
  tags = {
    Name = "10.0.1.0 Private Network Interface"
  }
}
resource "aws_instance" "www" {
  count         = var.num_instances
  ami           = "ami-0a8b4cd432b1c3063"
  instance_type = "t2.micro"
  network_interface {
    network_interface_id = aws_network_interface.ten_zero[count.index].id
    device_index         = 0
  }
  tags = {
    Name = "www${format("%02d", count.index + 1)}.${var.domain}"
  }
}
