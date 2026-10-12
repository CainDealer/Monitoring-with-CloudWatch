# Tạo S3 Bucket
aws s3api create-bucket --bucket cloudwatch-monitoring-logs-project --region us-east-1

# Gắn Tag
aws s3api put-bucket-tagging --bucket cloudwatch-monitoring-logs-project --tagging 'TagSet=[{Key=Project,Value=CloudWatch-Monitoring},{Key=Owner,Value=TuanKhang}]'

aws s3api put-public-access-block --bucket cloudwatch-monitoring-logs-project --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"