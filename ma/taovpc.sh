#!/bin/bash
set -e

REGION="us-east-1"


VPC_ID=$(aws ec2 create-vpc \
  --region "$REGION" \
  --cidr-block 10.0.0.0/16 \
  --tag-specifications \
  'ResourceType=vpc,Tags=[{Key=Name,Value=monitoring-vpc},{Key=Project,Value=CloudWatch-Monitoring},{Key=Owner,Value=TuanKhang}]' \
  --query 'Vpc.VpcId' \
  --output text)


aws ec2 modify-vpc-attribute \
  --region "$REGION" \
  --vpc-id "$VPC_ID" \
  --enable-dns-hostnames '{"Value":true}'

aws ec2 modify-vpc-attribute \
  --region "$REGION" \
  --vpc-id "$VPC_ID" \
  --enable-dns-support '{"Value":true}'

SUBNET_ID=$(aws ec2 create-subnet \
  --region "$REGION" \
  --vpc-id "$VPC_ID" \
  --cidr-block 10.0.1.0/24 \
  --tag-specifications \
  'ResourceType=subnet,Tags=[{Key=Name,Value=monitoring-public-subnet},{Key=Project,Value=CloudWatch-Monitoring},{Key=Owner,Value=TuanKhang}]' \
  --query 'Subnet.SubnetId' \
  --output text)

echo "SUBNET_ID=$SUBNET_ID"

IGW_ID=$(aws ec2 create-internet-gateway \
  --region "$REGION" \
  --tag-specifications \
  'ResourceType=internet-gateway,Tags=[{Key=Name,Value=monitoring-igw},{Key=Project,Value=CloudWatch-Monitoring},{Key=Owner,Value=TuanKhang}]' \
  --query 'InternetGateway.InternetGatewayId' \
  --output text)

echo "IGW_ID=$IGW_ID"

aws ec2 attach-internet-gateway \
  --region "$REGION" \
  --vpc-id "$VPC_ID" \
  --internet-gateway-id "$IGW_ID"

RT_ID=$(aws ec2 create-route-table \
  --region "$REGION" \
  --vpc-id "$VPC_ID" \
  --tag-specifications \
  'ResourceType=route-table,Tags=[{Key=Name,Value=monitoring-public-rt},{Key=Project,Value=CloudWatch-Monitoring},{Key=Owner,Value=TuanKhang}]' \
  --query 'RouteTable.RouteTableId' \
  --output text)


aws ec2 create-route \
  --region "$REGION" \
  --route-table-id "$RT_ID" \
  --destination-cidr-block 0.0.0.0/0 \
  --gateway-id "$IGW_ID"

aws ec2 associate-route-table \
  --region "$REGION" \
  --route-table-id "$RT_ID" \
  --subnet-id "$SUBNET_ID"

aws ec2 modify-subnet-attribute \
  --region "$REGION" \
  --subnet-id "$SUBNET_ID" \
  --map-public-ip-on-launch

aws ec2 describe-vpcs \
  --region "$REGION" \
  --vpc-ids "$VPC_ID" \
  --query 'Vpcs[*].[VpcId,CidrBlock,State,Tags]' \
  --output table

aws ec2 describe-subnets \
  --region "$REGION" \
  --subnet-ids "$SUBNET_ID" \
  --output table
