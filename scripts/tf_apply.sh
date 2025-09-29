#!/bin/bash
set -euo pipefail

if [ -z "$1" ]; then
  echo "Usage: $0 <terraform_root_path>"
  exit 1
fi

TF_ROOT="$1"
cd "$TF_ROOT"

echo "Applying Terraform plan..."
terraform apply -input=false tfplan

echo "Terraform apply completed."
