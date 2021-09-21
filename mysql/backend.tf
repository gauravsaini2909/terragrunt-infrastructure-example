terraform {
  backend "s3" {
    bucket         = "terragrunt-demo-poc"
    key            = "stage/mysql/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}