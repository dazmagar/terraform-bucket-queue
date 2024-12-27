variable "aws_region" {
  description = "The AWS region where the resources are located"
  type        = string
}

variable "account_id" {
  description = "The AWS account ID"
  type        = string
}

variable "group_name" {
  description = "The name of the IAM group to attach policies"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "queue_name" {
  description = "The name of the SQS queue"
  type        = string
}
