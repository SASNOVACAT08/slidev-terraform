terraform {
  backend "s3" {
    key     = "state/terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}
