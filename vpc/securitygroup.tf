resource "aws_security_group" "test" {
  vpc_id      = "${aws_vpc.Main_vpc.id}"
  name        = "Test"
  description = "security froup"
  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
  }
  ingress {
    from_port = 3389
    protocol  = "RDP"
    to_port   = 3389
  }
  tags = {
    name = "secutity group"
  }
}