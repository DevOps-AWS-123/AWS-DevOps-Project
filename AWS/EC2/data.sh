#!/bin/bash

#####IMDS v1
curl http://ip_address/latest/meta_data ###meta data information
curl http://ip_address/latest/meta_data/ami-id ##ami id
curl http://ip_address/latest/meta_data/instance_id ##get instance id
curl http://ip_address/latest/meta_data/placement/ ##get placement means azs

#####IMDS v2
#!/bin/bash

# Update system and install httpd (Apache)
sudo apt update -y
sudo apt install -y apache2

# Start httpd service and enable it to start on boot
systemctl start apache2
systemctl enable apache2

# Fetch metadata using IMDSv2
TOKEN=$(curl -X PUT "http://ip_address/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://ip_address/latest/meta-data/instance-id)
AMI_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://ip_address/latest/meta-data/ami-id)
INSTANCE_TYPE=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://ip_address/latest/meta-data/instance-type)

# Create a web page to display the metadata
cat <<EOF > /var/www/html/index.html
<html>
<head>
    <title>EC2 Instance Metadata</title>
</head>
<body>
    <h1>EC2 Instance Metadata</h1>
    <p>Instance ID: $INSTANCE_ID</p>
    <p>AMI ID: $AMI_ID</p>
    <p>Instance Type: $INSTANCE_TYPE</p>
</body>
</html>
EOF

