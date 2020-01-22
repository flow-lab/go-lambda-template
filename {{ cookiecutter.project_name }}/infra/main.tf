provider "aws" {
}

terraform {
  backend "s3" {
    bucket = "{{ cookiecutter.terraform_state_s3 }}"
    key    = var.name
    region = "{{ cookiecutter.aws_region }}"
  }
}