# Terraform VPC Infrastructure

## Project Overview

This project builds a VPC with both public and private subnets, using reusable modules and support for multiple environments (dev/prod).

## Structure

- `modules/network/`: Reusable network module
- `environments/dev/`: Environment-specific configuration
- `environments/prod/`: Another environment
- Remote state with locking enabled using S3 and DynamoDB

## How to Use

```bash
cd envs/dev
terraform init
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
