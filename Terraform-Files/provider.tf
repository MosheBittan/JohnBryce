# Terraform block - handles Requirements ( Version and Sources )
terraform {
  required_version = ">=1.7.0 , < 2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# provider block handles the actual configuration (like the region)
provider "aws" {
  region = "eu-north-1" # Replace with your preferred region, e.g., "eu-central-1"
}
