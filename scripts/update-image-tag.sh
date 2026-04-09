#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <image-tag>"
  echo "Example: $0 a1b2c3d"
  exit 1
fi

TAG="$1"
VALUES_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/helm/dr-demo/values.yaml"

sed -i.bak -E "s|^(\\s*tag:\\s*).*$|\\1${TAG}|g" "$VALUES_FILE"
rm -f "${VALUES_FILE}.bak"

echo "Updated Helm image tag to ${TAG}"
