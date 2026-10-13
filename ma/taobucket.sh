#!/bin/bash
set -e

BUCKET_NAME="student-project"
REGION="ap-southeast-1"

# Tạo S3 Bucket tại Singapore
aws s3api create-bucket \
  --bucket "$BUCKET_NAME" \
  --region "$REGION" \
  --create-bucket-configuration LocationConstraint="$REGION"

# Bật chặn truy cập công khai
aws s3api put-public-access-block \
  --bucket "$BUCKET_NAME" \
  --public-access-block-configuration \
  BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true

# Gắn tag cho Bucket
aws s3api put-bucket-tagging \
  --bucket "$BUCKET_NAME" \
  --tagging 'TagSet=[{Key=Project,Value=AWS-Lab},{Key=Environment,Value=Development},{Key=Owner,Value=Student}]'

# Kiểm tra Bucket
aws s3api head-bucket --bucket "$BUCKET_NAME"
aws s3api get-bucket-tagging --bucket "$BUCKET_NAME"

echo "Da tao S3 Bucket thanh cong: $BUCKET_NAME"
