terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.26.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
}

module "EC2" {
  source         = "./EC2"
}

module "PARAMETERS" {
  source         = "./PARAMETERS"
}

#module "RDS" {
#  source         = "./RDS"
#}

module "EFS" {
  source         = "./EFS"
}
