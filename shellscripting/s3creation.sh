#!/bin/bash
# Number of buckets to create
NUMBER_OF_BUCKETS=10
# Specify the AWS region where the buckets will be created
REGION="us-east-1"
# Loop to create multiple buckets
##The seq command in the script is used to generate a sequence of numbers, and here it specifically generates numbers from 1 to NUMBER_OF_BUCKETS
##we can use this is also (i=1; i<=NUMBER_OF_BUCKETS; i++)
for i in $(seq 1 $NUMBER_OF_BUCKETS); do
    # Generate a random string for the bucket name (using date and random number)
    #Epoch Time +%s
    BUCKET_NAME="s3-bucket-$(date +%s)-$RANDOM"

    # Create the bucket using the AWS CLI
    aws s3api create-bucket --bucket "$BUCKET_NAME" --region "$REGION" --create-bucket-configuration LocationConstraint="$REGION"

    # Check if the bucket was created successfully
    if [ $? -eq 0 ]; then
        echo "Bucket $i created successfully: $BUCKET_NAME"
    else
        echo "Error creating bucket $i."
    fi

    # Optional: Sleep for 1 second between creations to ensure unique timestamps
    sleep 1
done
