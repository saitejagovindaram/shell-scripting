#!/bin/bash

SERVICES=("web" "catalogue" "mongoDB" "shipping")
INSTANCE_TYPE=""
IMAGE_ID=ami-03265a0778a880afb
SG_ID=sg-009b25c0aa06c3c50


for svc in ${SERVICES[@]}
do
    if [ $svc == "shipping" ]; then
        INSTANCE_TYPE="t2.small"
    else
        INSTANCE_TYPE="t2.micro"
    fi

    RESULT=$(aws ec2 run-instances --image-id ami-03265a0778a880afb  --instance-type $INSTANCE_TYPE  --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$svc}]") 

    if [ $svc == "web" ]; then
        # aws route53 change-resource-record-sets --hosted-zone-id "Z0126075383L1GOMB15Q6" --change-batch "{"Changes":[{"Action":"CREATE","ResourceRecordSet":{"Type":"A","TTL":1,"ResourceRecords":[{"Value":"$RESULT.PublicIpAddress"}]}}]}"
        echo "$RESULT.Instances[0].PublicIpAddress"
    
    else

    fi
done


