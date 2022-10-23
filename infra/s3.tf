resource "aws_s3_bucket" "default" {
  tags = {
    Name = var.bucket_name
  }
}
