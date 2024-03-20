# terraform eks module
IaC for EKS in AWS Service

## How to Install

### Environments Settings
- Ubuntu 20.04

### Terraform Install
Terraform 설치는 [링크](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)를 참고 해주세요.

## File Tree
```
terraform-eks-modules
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug-report.md
│   │   ├── docs-request.md
│   │   ├── etc.md
│   │   └── feature-request.md
│   └── pull_request_template.md
└── terraform/
    ├── modules
    ├── sample.tfvars - terraform.tfvars without values
    ├── provider.tf
    ├── variables.tf
    ├── lacal.tf
    ├── $(services).tf
    └── etc ...
```

## How to Start

### 1. AWSCLI SSO 로그인

```bash
# 첫 생성시
$ aws configure sso

# 로그인
$ aws sso login --profile 프로필이름
```

### 2. terraform 명령어

```bash
# sso 정보로 terraform 사용시
$ export AWS_PROFILE=프로필이름

$ cd terraform

# terraform provider install
$ terraform init

# logic dependency check
$ terraform plan

# apply physical resources
$ terraform apply

# delete physical resources
$ terraform destory
```