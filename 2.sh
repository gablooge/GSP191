#!/bin/bash

cd terraform-google-lb/examples/basic

export GOOGLE_PROJECT=$(gcloud config get-value project)

terraform init
terraform plan
terraform apply

EXTERNAL_IP=$(terraform output | grep load_balancer_default_ip | cut -d = -f2 | xargs echo -n)
echo "http://${EXTERNAL_IP}"