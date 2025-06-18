resource "aws_s3_bucket" "proveedores" {
  count  = 6
  bucket = "provedores-${random_string.sufijo[count.index].id}"
  tags = {
    Owner       = "Edison"
    Environment = "Dev"
    Office      = "Provedores"
  }
}

resource "random_string" "sufijo" {
  count   = 6
  length  = 8
  special = false
  upper   = false
  numeric = false
}
