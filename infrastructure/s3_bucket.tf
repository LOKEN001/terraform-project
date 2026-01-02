resource "aws_s3_bucket" "s3-bucket" {
  bucket = "${bucket_name}-${var.env}"
  
  tags = {
    Name        = "${var.env}-bucket"
    Environment = var.env
  }
}
