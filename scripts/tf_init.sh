#!/bin/bash
set -euo pipefail

if [ -z "$1" ]; then
  echo "Usage: $0 <terraform_root_path>"
  exit 1
fi

TF_ROOT="$1"
cd "$TF_ROOT"

echo "Initializing Terraform in $TF_ROOT..."
terraform -version

terraform init -input=false \
  -backend-config="bucket=${TF_BACKEND_BUCKET}" \
  -backend-config="region=${TF_REGION}" \
  -backend-config="key=${TF_STATE_KEY}"
