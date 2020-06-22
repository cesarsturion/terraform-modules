# Configure the AWS Provider
provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "gudiao-labs-tfstates-terraform"
    key    = "modules/terraformt.tfstate"
    region = "us-east-1"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs               = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

  public_subnets    = ["10.0.201.0/24", "10.0.202.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true

  private_subnets   = ["10.0.101.0/24", "10.0.102.0/24"]

  database_subnets  = ["10.0.301.0/24", "10.0.302.0/24"]
  create_database_subnet_group = false

  mgmt_subnets     = ["10.0.401.0/24", "10.0.402.0/24"]


  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}