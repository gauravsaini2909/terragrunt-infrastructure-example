terraform {
  backend "s3" {
    bucket         = "terragrunt-demo-poc"
    key            = "stage/frontend/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}