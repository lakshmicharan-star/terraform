resource "aws_instance" "Testserver" {
  ami                    = "${lookup(var.wins_ami, var.region)}"
  instance_type          = "t2.micro"
  tenancy                = "default"
  subnet_id              = "${aws_subnet.Public_subnet1.id}"
  vpc_security_group_ids = ["${aws_security_group.test.id}"]
  key_name               = "test"
  tags = {
    Name = "Test"
  }
}

output "IP" {
  value = "${aws_eip.nat_IP.id}"
}

resource "aws_instance" "Testserver_private" {
  ami = "${lookup(var.wins_ami,var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.Private_subnet2.id}"
  security_groups = ["sg-09404c54f7e81b404"]
  key_name = "test"
  vpc_security_group_ids = ["${aws_security_group.test.id}"]
}