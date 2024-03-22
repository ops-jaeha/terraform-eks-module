# Required Terraform Provider
terraform {
  required_version = "1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.24.0"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.0.2"
    }
  }
}

# AWS Provider Settings
provider "aws" {
  # 기타 쿠버네티스 관련 컨트롤러들이 생성하는 태그가 덮어쓰여지지 않도록 설정
  ignore_tags {
    key_prefixes = ["kubernetes.io/", "karpenter.sh/discovery"]
  }
  # 해당 테라폼 모듈을 통해서 생성되는 모든 AWS 리소스에 아래의 태그 부여
  default_tags {
    tags = local.tags
  }
}