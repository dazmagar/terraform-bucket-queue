# Terraform Project: S3 to SQS Integration

This Terraform project provisions AWS infrastructure to enable a seamless integration between **Amazon S3** and **Amazon SQS**, allowing S3 events (e.g., file uploads) to trigger messages sent to an SQS queue.

## Features

- **Amazon S3 Bucket**:
  - Bucket for storing uploaded files.
  - Notification system to send events to an SQS queue.

- **Amazon SQS Queue**:
  - Queue to receive notifications from the S3 bucket.
  - Configured with attributes like delay, message size, and retention period.

- **IAM Policies**:
  - Custom permissions for managing the S3 bucket and SQS queue.
  - Policies attached to a group (`terraform-infra-group`) for streamlined permission management.

## Project Structure

```
.
|-- main.tf                # Main configuration for calling modules
|-- provider.tf            # AWS provider configuration
|-- variables.tf           # Global variables
|-- terraform.tfvars       # Values for global variables
|-- modules/
    |-- iam_policies/      # IAM Policies module
    |   |-- main.tf
    |   |-- variables.tf
    |   |-- outputs.tf
    |
    |-- infrastructure/    # S3 and SQS setup module
        |-- main.tf
        |-- variables.tf
        |-- outputs.tf
```

## Prerequisites

- **Terraform** v1.0 or higher.
- AWS CLI configured with a profile that has Access Key and Secret Access Key.

### Setting Up an IAM User and Group

1. **Create an IAM Group**:
   - Go to the AWS Management Console → **IAM** → **Groups** → **Create Group**.
   - Name the group, e.g., `terraform-infra-group`.
   - Attach the following AWS Managed Policies to the group:
     - **AmazonS3FullAccess**
     - **AmazonSQSFullAccess**
     - **IAMFullAccess**

2. **Create an IAM User**:
   - Go to the AWS Management Console → **IAM** → **Users** → **Create User**.
   - Name the user, e.g., `terraform-infra-user`.
   - Select **Programmatic access** to generate an Access Key and Secret Access Key.
   - Add the user to the group `terraform-infra-group`.

3. **Configure the AWS CLI**:
   - Use the Access Key and Secret Access Key from the created user to configure the AWS CLI:
     ```bash
     aws configure
     ```
   - Enter the following values:
     - **AWS Access Key ID**: `<Access Key>`
     - **AWS Secret Access Key**: `<Secret Key>`
     - **Default region**: `us-east-1` (or your preferred region).
   - Use the profile `default` in the Terraform provider configuration:
     ```hcl
     provider "aws" {
       region  = "us-east-1"
       profile = "default"
     }
     ```

## Usage

### 1. Clone the Repository
```bash
git clone <repo>
cd <repo-folder>
```

### 2. Initialize Terraform
```bash
terraform init
```

### 3. Review the Plan
```bash
terraform plan
```
### 4. Apply the Configuration
```bash
terraform apply
```
### 5. Test the Setup
Upload a file to the S3 bucket:
```bash
echo "Test file content" > test-file.txt
aws s3 cp test-file.txt s3://upload-bucket-for-sqs/
```
Check messages in the SQS queue:
```bash
aws sqs receive-message --queue-url https://sqs.{aws_region}.amazonaws.com/{account_id}/upload-queue
```
Delete messages after processing:
```bash
aws sqs delete-message --queue-url https://sqs.{aws_region}.amazonaws.com/{account_id}/upload-queue --receipt-handle {receipt-handle}
```
Delete file from s3
```bash
aws s3 rm s3://upload-bucket-for-sqs/test-file.txt
```

## Variables

Key variables for this project are listed below. Default values are stored in `terraform.tfvars`:

| Variable      | Description                             | Example Value             |
|---------------|-----------------------------------------|---------------------------|
| `aws_region`  | AWS region where resources are deployed | `us-east-1`               |
| `aws_profile` | AWS profile                             | `default`                 |
| `account_id`  | AWS Account ID                          | `<account_id>`            |
| `group_name`  | IAM group for managing permissions      | `terraform-infra-group`   |
| `bucket_name` | Name of the S3 bucket                   | `upload-bucket-for-sqs`   |
| `queue_name`  | Name of the SQS queue                   | `upload-queue`            |

## Outputs

| Output Name         | Description                              |
|---------------------|------------------------------------------|
| `s3_bucket_arn`     | ARN of the provisioned S3 bucket         |
| `sqs_queue_arn`     | ARN of the provisioned SQS queue         |
| `iam_policy_arn`    | ARN of the custom IAM policy             |

## Limitations
- Notifications are only triggered for `s3:ObjectCreated:*` events.
- Ensure that S3 bucket names are globally unique.

## Clean-Up

To destroy all resources provisioned by this project, run:
```bash
terraform destroy
```
