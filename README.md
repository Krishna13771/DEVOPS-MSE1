# Terraform Multi-Environment AWS

This project creates **Dev and Prod environments on AWS using Terraform**.

## Technologies

* Terraform
* AWS EC2
* Terraform Workspaces

## Project Structure

```text
terraform-multi-env/
├── main.tf
├── variables.tf
├── terraform.tf
├── terraform.tfvars.dev
├── terraform.tfvars.prod
├── .gitignore
└── README.md
```

## Environments

| Environment | Instance | Count |
| ----------- | -------- | ----: |
| Dev         | t3.micro |     1 |
| Prod        | t3.small |     3 |

## Features

* Terraform Workspaces
* Terraform Variables
* Different `.tfvars` files for Dev and Prod
* AWS Data Sources
* EC2 provisioning
* Resource tagging
* Separate state for each environment

## Setup

Initialize Terraform:

```bash
terraform init
```

Check configuration:

```bash
terraform validate
```

Format code:

```bash
terraform fmt
```

## Deploy Dev

```bash
terraform workspace select dev
terraform apply -var-file="terraform.tfvars.dev"
```

## Deploy Prod

```bash
terraform workspace select prod
terraform apply -var-file="terraform.tfvars.prod"
```

## Check Workspaces

```bash
terraform workspace list
```

## Destroy Resources

Dev:

```bash
terraform workspace select dev
terraform destroy -var-file="terraform.tfvars.dev"
```

Prod:

```bash
terraform workspace select prod
terraform destroy -var-file="terraform.tfvars.prod"
```

## Objective

To demonstrate **multi-environment AWS infrastructure using Terraform Workspaces, Variables, Data Sources, and EC2**.
