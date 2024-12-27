resource "aws_iam_policy" "custom_s3_policy" {
  name        = "custom-s3-policy"
  description = "Policy to allow S3 bucket notifications and policy updates"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutBucketPolicy",
          "s3:GetBucketPolicy",
          "s3:DeleteBucketPolicy",
          "s3:PutBucketNotification",
          "s3:GetBucketNotification"
        ],
        Resource = "arn:aws:s3:::${var.bucket_name}"
      },
      {
        Effect = "Allow",
        Action = [
          "sqs:SendMessage",
          "sqs:GetQueueAttributes",
          "sqs:SetQueueAttributes"
        ],
        Resource = "arn:aws:sqs:${var.aws_region}:${var.account_id}:${var.queue_name}"
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "custom_s3_policy_attachment" {
  group      = var.group_name
  policy_arn = aws_iam_policy.custom_s3_policy.arn
}
