resource "aws_s3_bucket" "bucket_s3" {
  bucket = local.s3-sufix
}
