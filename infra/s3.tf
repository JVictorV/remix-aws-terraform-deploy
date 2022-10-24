resource "aws_s3_bucket" "default" {
  tags = {
    Name = var.bucket_name
  }
}

resource "aws_s3_bucket_acl" "default_bucket_acl" {
  bucket = aws_s3_bucket.default.id
  acl    = "public-read"
}


resource "aws_s3_object" "frontend_files" {
  for_each = module.template_files.files

  bucket       = aws_s3_bucket.default.id
  key          = each.key
  content_type = each.value.content_type

  source  = each.value.source_path
  content = each.value.content
  etag    = each.value.digests.md5
}


resource "aws_s3_bucket_policy" "access_s3_from_cloudfront_policy" {
  bucket = aws_s3_bucket.default.id
  policy = data.aws_iam_policy_document.allow_s3_access_from_cloudfront.json
}

