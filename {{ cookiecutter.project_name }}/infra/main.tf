data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

provider "aws" {
}

terraform {
  backend "s3" {
    encrypt = true
    bucket  = "{{ cookiecutter.terraform_state_s3 }}"
    key     = "{{ cookiecutter.project_slug }}"
    region  = "{{ cookiecutter.aws_region }}"
  }
}