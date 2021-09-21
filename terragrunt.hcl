remote_state {
  backend = "s3"
  config = {
    bucket = "terragrunt-demo-poc"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    
  }
}
inputs = {
  ami = "ami-0a23ccb2cdd9286bb"
  instance_type  = "t2.micro"
}