#!/bin/bash

sudo aws ssm put-parameter \
  --name "AmazonCloudWatch-Linux-EC2-Config" \
  --type "String" \
  --value file:///opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
  --region us-east-1