resource "aws_vpc" "Main_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_classiclink   = "false"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
  tags = {
    Name = "Public_vpc"
  }
}

resource "aws_subnet" "Public_subnet1" {
  cidr_block              = "10.0.1.0/24"
  vpc_id                  = "${aws_vpc.Main_vpc.id}"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "Public_subnet1"
  }
}

resource "aws_subnet" "Public_subnet2" {
  cidr_block              = "10.0.2.0/24"
  vpc_id                  = "${aws_vpc.Main_vpc.id}"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "Public_subnet2"
  }
}

resource "aws_internet_gateway" "IGW_Main" {
  vpc_id = "${aws_vpc.Main_vpc.id}"
  tags = {
    Name = "Main_IGW"
  }
}

resource "aws_route_table" "Routetable" {
  vpc_id = "${aws_vpc.Main_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.IGW_Main.id}"
  }
  tags = {
    Name = "Main routetabel"
  }
}

resource "aws_route_table_association" "main-public-1a" {
  route_table_id = "${aws_route_table.Routetable.id}"
  subnet_id      = "${aws_subnet.Public_subnet1.id}"
}

resource "aws_route_table_association" "Main-public-1b" {
  route_table_id = "${aws_route_table.Routetable.id}"
  subnet_id      = "${aws_subnet.Public_subnet2.id}"
}