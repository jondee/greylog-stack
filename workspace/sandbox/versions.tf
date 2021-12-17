terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.69.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.7.0"
    }
  }
  required_version = ">= 0.14"
}