output "custom_s3_policy_arn" {
  value       = aws_iam_policy.custom_s3_policy.arn
  description = "The ARN of the custom S3 policy"
}
