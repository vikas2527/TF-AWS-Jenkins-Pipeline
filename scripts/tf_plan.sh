#!/bin/bash
set -euo pipefail

if [ -z "$1" ]; then
  echo "Usage: $0 <terraform_root_path>"
  exit 1
fi

TF_ROOT="$1"
cd "$TF_ROOT"

echo "Formatting Terraform code..."
terraform fmt -check || terraform fmt

echo "Validating Terraform configuration..."
terraform validate

echo "Creating Terraform plan..."
terraform plan -input=false -out=tfplan

echo "Saving plan as JSON..."
terraform show -json tfplan > tfplan.json

echo "Terraform plan complete."
