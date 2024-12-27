module "iam_policies" {
  source      = "./modules/iam_policies"
  group_name  = var.group_name
  bucket_name = var.bucket_name
  queue_name  = var.queue_name
  aws_region  = var.aws_region
  account_id  = var.account_id
}


module "infrastructure" {
  source      = "./modules/infrastructure"
  bucket_name = var.bucket_name
  queue_name  = var.queue_name
}
