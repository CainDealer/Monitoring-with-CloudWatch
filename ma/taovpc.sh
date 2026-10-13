
#!/bin/bash
set -e

REGION="ap-southeast-1"
VPC_CIDR="10.0.0.0/16"
SUBNET_CIDR="10.0.1.0/24"

# 1. Tao VPC
VPC_ID=$(aws ec2 create-vpc \
  --cidr-block "$VPC_CIDR" \
  --region "$REGION" \
  --tag-specifications \
  'ResourceType=vpc,Tags=[{Key=Name,Value=StudentProject-VPC},{Key=Project,Value=AWS-Lab}]' \
  --query 'Vpc.VpcId' \
  --output text)

echo "VPC ID: $VPC_ID"

# Bat DNS cho VPC
aws ec2 modify-vpc-attribute \
  --vpc-id "$VPC_ID" \
  --enable-dns-support '{"Value":true}'

aws ec2 modify-vpc-attribute \
  --vpc-id "$VPC_ID" \
  --enable-dns-hostnames '{"Value":true}'

# 2. Tao Public Subnet
SUBNET_ID=$(aws ec2 create-subnet \
  --vpc-id "$VPC_ID" \
  --cidr-block "$SUBNET_CIDR" \
  --availability-zone "${REGION}a" \
  --tag-specifications \
  'ResourceType=subnet,Tags=[{Key=Name,Value=StudentProject-Public-Subnet},{Key=Project,Value=AWS-Lab}]' \
  --query 'Subnet.SubnetId' \
  --output text)

echo "Subnet ID: $SUBNET_ID"

# Tu dong gan public IPv4 cho instance trong subnet
aws ec2 modify-subnet-attribute \
  --subnet-id "$SUBNET_ID" \
  --map-public-ip-on-launch

# 3. Tao Internet Gateway
IGW_ID=$(aws ec2 create-internet-gateway \
  --tag-specifications \
  'ResourceType=internet-gateway,Tags=[{Key=Name,Value=StudentProject-IGW},{Key=Project,Value=AWS-Lab}]' \
  --query 'InternetGateway.InternetGatewayId' \
  --output text)

echo "Internet Gateway ID: $IGW_ID"

# Gan IGW vao VPC
aws ec2 attach-internet-gateway \
  --vpc-id "$VPC_ID" \
  --internet-gateway-id "$IGW_ID"

# 4. Tao Route Table
RT_ID=$(aws ec2 create-route-table \
  --vpc-id "$VPC_ID" \
  --tag-specifications \
  'ResourceType=route-table,Tags=[{Key=Name,Value=StudentProject-Public-RT},{Key=Project,Value=AWS-Lab}]' \
  --query 'RouteTable.RouteTableId' \
  --output text)

echo "Route Table ID: $RT_ID"

# Them route ra Internet
aws ec2 create-route \
  --route-table-id "$RT_ID" \
  --destination-cidr-block "0.0.0.0/0" \
  --gateway-id "$IGW_ID"

# Gan Route Table vao Subnet
aws ec2 associate-route-table \
  --route-table-id "$RT_ID" \
  --subnet-id "$SUBNET_ID"

# 5. Xuat thong tin tai nguyen
echo THONG TIN VPC "
aws ec2 describe-vpcs \
  --vpc-ids "$VPC_ID" \
  --query 'Vpcs[*].[VpcId,CidrBlock,State]' \
  --output table

echo THONG TIN SUBNET "
aws ec2 describe-subnets \
  --subnet-ids "$SUBNET_ID" \
  --query 'Subnets[*].[SubnetId,CidrBlock,AvailabilityZone]' \
  --output table

echo TAO VPC THANH CONG "
echo "VPC_ID=$VPC_ID"
echo "SUBNET_ID=$SUBNET_ID"
echo "IGW_ID=$IGW_ID"
echo "ROUTE_TABLE_ID=$RT_ID"
