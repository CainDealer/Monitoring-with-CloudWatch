#!/bin/bash
set -e

BUCKET_NAME="cloudwatch-monitoring-logs-project"
REGION="us-east-1"

aws s3api create-bucket \
  --bucket "$BUCKET_NAME" \
  --region "$REGION"

aws s3api put-bucket-tagging \
  --bucket "$BUCKET_NAME" \
  --region "$REGION" \
  --tagging 'TagSet=[{Key=Project,Value=CloudWatch-Monitoring},{Key=Owner,Value=TuanKhang}]'

aws s3api put-public-access-block \
  --bucket "$BUCKET_NAME" \
  --region "$REGION" \
  --public-access-block-configuration \
  "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"
