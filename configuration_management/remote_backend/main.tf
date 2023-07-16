resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "appsilon-terraform-state-bucket"

  versioning {
    enabled = true
  }
  
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  bucket_acl {
    owner_grants {
      id          = aws_caller_identity.current.account_id
      permissions = ["FULL_CONTROL"]
    }
  }

  lifecycle {
    prevent_destroy = true
  }

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_lock_table" {
  name           = "appsilon-dynamodb-lock-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}