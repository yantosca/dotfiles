#!/bin/bash

### Script to open a c5 instance on EC2

# Get instance number from command line, or default to "2" (aka c5.2xlarge)
[[ "x${1}" == "x" ]] && instnum=2 || instnum="${1}"

# Define tags
tags="{Key=Name,Value=Bob_Y_Dev}"
tags="ResourceType=instance,Tags=[${tags}]"

# Almost never change, leave as-is
aws ec2 run-instances                                         \
    --image-id              ami-09b9b4f0153c3c1e4             \
    --key-name              bmy_aws_keypair                   \
    --security-groups       default-gc-cloud-sg               \
    --instance-type         c5.${instnum}xlarge               \
    --iam-instance-profile  Name=benchmarks-cloud-ec2-profile \
    --tag-specification     ${tags}
