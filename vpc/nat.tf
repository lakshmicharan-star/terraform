resource "aws_eip" "nat_IP" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = "${aws_eip.nat_IP.id}"
  subnet_id     = "${aws_subnet.Private_subnet1.id}"
  depends_on    = [aws_internet_gateway.IGW_Main]
}

resource "aws_subnet" "Private_subnet1" {
  cidr_block              = "10.0.5.0/24"
  vpc_id                  = "${aws_vpc.Main_vpc.id}"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1a"
  tags = {
    Names = "Private_subnet1"
  }
}

resource "aws_subnet" "Private_subnet2" {
  cidr_block              = "10.0.6.0/24"
  vpc_id                  = "${aws_vpc.Main_vpc.id}"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1b"
}

#vpc for nat gateway
resource "aws_route_table" "main_private" {
  vpc_id = "${aws_vpc.Main_vpc.id}"
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gw.id}"
    }
  tags = {
    Name = "natroute"
  }
}

resource "aws_route_table_association" "nat" {
  route_table_id = "${aws_route_table.main_private.id}"
  subnet_id      = "${aws_subnet.Private_subnet1.id}"
}

resource "aws_route_table_association" "nat1" {
  route_table_id = "${aws_route_table.main_private.id}"
  subnet_id      = "${aws_subnet.Private_subnet2.id}"
}
