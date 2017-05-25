#!/bin/bash -v
curl https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install > /tmp/install.sh
chmod +x /tmp/install.sh
/tmp/install.sh auto
rm /tmp/install.sh
