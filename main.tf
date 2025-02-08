provider "aws" {
  region  = "us-east-1"
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
  bucket = "lamars-practice-bucket-cicd" 
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
    bucket       = "lamars-cicd-practice"
    key          = "backend/terraform.tfstate"
    region       = "us-east-2"
  }
}



output "bucket_id" {
  description = "Bucket ID"
  value = aws_s3_bucket.tf_s3_cicd.id
}