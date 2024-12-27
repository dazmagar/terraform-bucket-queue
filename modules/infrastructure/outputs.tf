output "s3_bucket_arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "The ARN of the S3 bucket"
}

output "sqs_queue_arn" {
  value       = aws_sqs_queue.queue.arn
  description = "The ARN of the SQS queue"
}
