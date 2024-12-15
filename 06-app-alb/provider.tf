terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.62.0"
    }
  }
  backend "s3" {
    bucket = "daws78s-rev-remote-state"
    key    = "expense-dev-app-alb"
    region = "us-east-1"
    dynamodb_table = "daws78s-locking"
  }
}

#provide authentication here
provider "aws" {
  region = "us-east-1"
}