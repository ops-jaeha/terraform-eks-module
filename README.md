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
    ├── lacals.tf
    ├── $(services).tf
    └── etc ...
```

## How to Start
```bash
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