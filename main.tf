terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "wordpress" {
  source = "./modules/wordpress"

  vpc_id      = var.vpc_id
  subnet_id   = var.subnet_id
  my_ip       = var.my_ip
  key_name    = var.key_name
  domain_name = var.domain_name
}