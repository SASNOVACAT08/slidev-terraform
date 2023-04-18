module "slidev" {
  source = "./modules/slidev"

  aws_region = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
  bucket_name = var.bucket_name
  origin_id = var.origin_id 
}