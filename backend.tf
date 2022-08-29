provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  required_version = "1.2.7"
  backend "s3" {
    bucket = "guojun-terraform-lesson-tfstate"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}
