variable "aws_region" {
  default = "eu-west-1"
  type    = string
}

variable "access_key" {
  sensitive = true
  type      = string
}

variable "secret_key" {
  sensitive = true
  type      = string
}

variable "remote_name" {
  sensitive = false
  type      = string
}
