provider "aws" {
  region = "ap-south-1"
  # ... other provider settings ...
}

resource "aws_instance" "frontend_test" {
ami = var.ami
instance_type = var.instance_type

}