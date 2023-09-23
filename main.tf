terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.67.0"
    }
  }

  # backend "kubernetes" {
  #   secret_suffix = "okteto"
  # }

  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "tfstate-219858395663"
    key            = "oktetodo/terraform.tfstate"
    region         = "us-west-1"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "tfstate-219858395663"
    encrypt        = true
  }
}

variable "bucket_name" {
  description = "Name of the S3 Bucket"
  type        = string
  default     = ""
  validation {
    condition     = length(var.bucket_name) > 1
    error_message = "Please specify the name of the S3 bucket"
  }
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-1"
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "todos_bucket" {
  bucket        = var.bucket_name
  force_destroy = true
}
