terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "daws78s-rev-remote-state"
    key    = "expense-dev-vpc"
    region = "us-east-1"
    dynamodb_table = "daws78s-locking"
  }
}


# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a ec2
