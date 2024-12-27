variable "aws_region" {
  description = "AWS region to use"
  type        = string
}

variable "aws_profile" {
  description = "AWS CLI profile to use"
  type        = string
}

variable "account_id" {
  description = "The AWS account ID"
  type        = string
}

variable "group_name" {
  description = "The name of the IAM group"
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
