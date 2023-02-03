resource "aws_s3_bucket" "web" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "web" {
  bucket = aws_s3_bucket.web.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "web" {
  bucket = aws_s3_bucket.web.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_website_configuration" "web" {
  bucket = aws_s3_bucket.web.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

resource "aws_s3_bucket_cors_configuration" "web" {
  bucket = aws_s3_bucket.web.bucket
  cors_rule {
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
  }
}

data "aws_iam_policy_document" "web_s3_policy" {
  statement {
    actions = [
      "s3:GetObject",
    ]
    resources = [
      "${aws_s3_bucket.web.arn}/*",
    ]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }

  depends_on = [
    aws_cloudfront_origin_access_identity.origin_access_identity
  ]
}

resource "aws_s3_bucket_policy" "web" {
  bucket = aws_s3_bucket.web.id
  policy = data.aws_iam_policy_document.web_s3_policy.json

  depends_on = [
    data.aws_iam_policy_document.web_s3_policy
  ]
}

resource "aws_s3_bucket_public_access_block" "web" {
  bucket              = aws_s3_bucket.web.id
  block_public_acls   = true
  block_public_policy = true
}