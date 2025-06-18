terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.82.0, <6.0.0, !=5.99.1"
    }
  }
  required_version = "~>1.11.0"
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = var.tags
  }
}
