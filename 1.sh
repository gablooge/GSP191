#!/bin/bash
gcloud auth revoke --all

while [[ -z "$(gcloud config get-value core/account)" ]]; 
do echo "waiting login" && sleep 2; 
done

while [[ -z "$(gcloud config get-value project)" ]]; 
do echo "waiting project" && sleep 2; 
done

cd terraform-google-lb/examples/basic

export GOOGLE_PROJECT=$(gcloud config get-value project)

terraform init
terraform plan
terraform apply

EXTERNAL_IP=$(terraform output | grep load_balancer_default_ip | cut -d = -f2 | xargs echo -n)
echo "http://${EXTERNAL_IP}"