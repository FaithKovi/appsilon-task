terraform {
  backend "s3" {
    bucket         = "appsilon-terraform-state-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "appsilon-dynamodb-lock-table"
    encrypt        = true
    acl            = "bucket-owner-full-control"
  }
}
