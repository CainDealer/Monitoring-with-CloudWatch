#!/bin/bash
# kiểm tra vpc
aws ec2 describe-vpcs \
  --region us-east-1 \
  --query "Vpcs[*].{VpcId:VpcId,CIDR:CidrBlock,State:State,Default:IsDefault}" \
  --output table

# kiểm tra subnet
aws ec2 describe-subnets \
  --region us-east-1 \
  --query "Subnets[*].{SubnetId:SubnetId,VpcId:VpcId,CIDR:CidrBlock,AZ:AvailabilityZone}" \
  --output table

# kiểm tra security group
aws ec2 describe-security-groups \
  --region us-east-1 \
  --query "SecurityGroups[*].{Name:GroupName,ID:GroupId,VPC:VpcId,Description:Description}" \
  --output table

# xem các quy tắc inbound và outbound
aws ec2 describe-security-groups \
  --region us-east-1 \
  --query "SecurityGroups[*].{Name:GroupName,Inbound:IpPermissions,Outbound:IpPermissionsEgress}" \
  --output json

# kiểm tra s3 bucket
aws s3api head-bucket \
  --bucket cloudwatch-monitoring-logs-project