provider "aws" {
  region  = "us-east-2"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

}

resource "aws_s3_bucket" "tf_s3_cicd" {
  bucket = "lamars-bucket-wk14" 
  tags = {
    "name" = "tfcicd-bucket",
    "team" = "devops"
    "role" = "sre"
    "company" = "cp"
    "text" = "checking pull request"
  }
}

terraform {
  backend "s3" {
    bucket       = "lamars-practice-bucket-cicd"
    key          = "backend/terraform.tfstate"
    region       = "us-east-2"
  }
}



output "bucket_id" {
  description = "Bucket ID"
  value = aws_s3_bucket.tf_s3_cicd.id
}