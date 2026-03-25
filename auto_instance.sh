#! /bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
SG_ID="sg-0d65ce3293312c4fc"
Host_zone="Z05398341DY1M46G62WSX"
DOMAIN="chaitanya.cloud"


for instance in $@
do

    ins_id=$(aws ec2 run-instances --image-id $AMI_ID --instance-type t3.micro --security-group-ids $SG_ID --tag-specifications   "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" --query 'Instances[0].InstanceId' --output text)

    if [ $instance == "frontend" ]; then
        IP=$(aws ec2 describe-instances --instance-ids $ins_id --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)
        record_name="$DOMAIN"
    else
        IP=$(aws ec2 describe-instances --instance-ids $ins_id --query 'Reservations[0].Instances[0].PrivateIpAddress' --output text)
        record_name="$instance.$DOMAIN"
    fi

    echo "$IP" 

    aws route53 change-resource-record-sets
    --hosted-zone-id $Host_zone
    --change-batch '
    {
        "Comment" : "dns record update"
        ,"Changes":[{
            "Action" : "UPSERT"
            ,"ResourceRecordSet":{
                "Name" : "'$record_name'"
                ,"Type" : "A"
                ,"TTL" : 1
                ,"ResourceRecords" : [{
                    "value" : "'$IP'"
                }]
                }
            }
        }]
    }
    '

    echo " $instance : $IP and DNS: $record_name"

done

