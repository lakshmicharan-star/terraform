terraform {
  backend "s3" {
bucket = "eterraformd"
    key = "terraform"
  }
}