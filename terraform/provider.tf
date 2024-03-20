# Required Terraform Provider
terraform {
  required_version = "1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
}

# AWS Provider Settings
provider "aws" {
  # 해당 테라폼 모듈을 통해서 생성되는 모든 AWS 리소스에 아래의 태그 부여
  default_tags {
    tags = local.tags
  }
}
