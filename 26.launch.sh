#!/bin/bash

SERVICES=("web" "catalogue" "mongoDB" "shipping" "mysql" "user" "cart" "rabbitmq" "payments" "ratings" "redis"  )
INSTANCE_TYPE=""
IMAGE_ID=ami-03265a0778a880afb
SG_ID=sg-009b25c0aa06c3c50


for svc in ${SERVICES[@]}
do
    if [ $svc == "shipping" ] || [ $svc == "mysql"]; then
        INSTANCE_TYPE="t2.small"
    else
        INSTANCE_TYPE="t2.micro"
    fi

    RESULT=$(aws ec2 run-instances --image-id ami-03265a0778a880afb  --instance-type $INSTANCE_TYPE  --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$svc}]") 

    Instance_id=$(echo "$RESULT" | jq -r '.Instances[0].InstanceId')
    if [ $svc == "web" ]; then
        PUBLIC_IP=$(aws ec2 describe-instances --instance-ids i-064f57e1e40dbfdef --query "Reservations[0].Instances[0].PublicIpAddress")
        
        # aws ec2 describe-instances --instance-ids $Instance_id
        # use --query to get the public ip
        echo "PUBLICIP: $PUBLIC_IP"
        aws route53 change-resource-record-sets 
            --hosted-zone-id "Z0126075383L1GOMB15Q6" 
            --change-batch "
                {
                    "Changes":[
                        {
                            "Action":"CREATE",
                            "ResourceRecordSet":{
                                "Type":"A",
                                "TTL":1,
                                "ResourceRecords":[
                                    {
                                        "Value":"$PUBLIC_IP"
                                    }
                                ]
                            }
                        }
                    ]
                }
            "

    else
        PRIVATE_IP=$(aws ec2 describe-instances --instance-ids i-064f57e1e40dbfdef --query "Reservations[0].Instances[0].PrivateIpAddress")
        echo "PRIVATEIP: $PRIVATE_IP"
        aws route53 change-resource-record-sets 
            --hosted-zone-id "Z0126075383L1GOMB15Q6" 
            --change-batch "
                {
                    "Changes":[
                        {
                            "Action":"CREATE",
                            "ResourceRecordSet":{
                                "Type":"A",
                                "TTL":1,
                                "ResourceRecords":[
                                    {
                                        "Value":"$PRIVATE_IP"
                                    }
                                ]
                            }
                        }
                    ]
                }
            "
    fi
done


