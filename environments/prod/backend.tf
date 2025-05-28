terraform {
  backend "s3" {
    bucket         = "my-terraform-stateprod"
    key            = "network/prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks-prod"
    encrypt        = true
  }
}
