variable "region" {
  default = "ap-south-1"
}

variable "wins_ami" {
  type = "map"
  default = {
    ap-south-1 = "ami-00b2d3ea9077fcebf"
  }
}