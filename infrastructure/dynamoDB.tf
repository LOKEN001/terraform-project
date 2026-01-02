resource "aws_dynamodb_table" "tf_lock" {
  name         = "${var.env}-terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.hash-key

  attribute {
    name = var.hash-key
    type = "S"
  }
}
