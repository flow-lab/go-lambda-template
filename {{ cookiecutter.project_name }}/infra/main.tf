data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

provider "aws" {
  version = "~> 2.46"

  //  assume_role {
  //    role_arn     = "arn:aws:iam::ACCOUNT_ID:role/terraform"
  //    session_name = "terraform-{{ cookiecutter.project_slug }}"
  //  }
}

terraform {
  backend "s3" {
    encrypt = true
    bucket  = "{{ cookiecutter.terraform_state_s3 }}"
    key     = "{{ cookiecutter.project_slug }}"
    region  = "{{ cookiecutter.aws_region }}"
  }
}