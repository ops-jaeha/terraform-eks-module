# terraform private eks module
- Automate VPC creation
- Create Private EKS use eks modules in terraform

## How to Install

### Environments Settings
- Ubuntu 20.04

### Terraform Install
Terraform 설치는 [link](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)를 참고 해주세요.

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

### 1. AWSCLI SSO Login

```bash
# if you first use sso in awscli
$ aws configure sso

# if you required sso login
$ aws sso login --profile profile_name
```

### 2. terraform command

```bash
# terraform use sso
$ export AWS_PROFILE=profile_name

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