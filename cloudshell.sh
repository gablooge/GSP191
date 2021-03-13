#!/bin/bash

cd ~/

git clone https://github.com/GoogleCloudPlatform/terraform-google-lb
cd ~/terraform-google-lb/examples/basic

export GOOGLE_PROJECT=$(gcloud config get-value project)

terraform init
terraform plan -out=tfplan -var "project_id=$GOOGLE_PROJECT"
terraform apply tfplan

EXTERNAL_IP=$(terraform output | grep load_balancer_default_ip | cut -d = -f2 | xargs echo -n)
echo "http://${EXTERNAL_IP}"