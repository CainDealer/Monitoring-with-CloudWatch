#!/bin/bash

VPC_ID=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=monitoring-vpc},{Key=Project,Value=CloudWatch-Monitoring},{Key=Owner,Value=TuanKhang}]' --query 'Vpc.VpcId' --output text)

aws ec2 modify-vpc-attribute --vpc-id $VPC_ID --enable-dns-hostnames "{\"Value\":true}"
