#!/usr/bin/env bash
# Simple deploy script for Nexlayer (static site)
# Requires the environment variable NEXLAYER_TOKEN to be set.

set -euo pipefail

if [ -z "${NEXLAYER_TOKEN:-}" ]; then
  echo "NEXLAYER_TOKEN is not set. Exiting."
  exit 1
fi

echo "Packaging site..."
zip -r site.zip . -x .git/* .github/* 

echo "Uploading to Nexlayer..."
# Replace the URL below with the Nexlayer API endpoint for deployments if different.
curl -sS -X POST "https://api.nexlayer.io/v1/deploy" \
  -H "Authorization: Bearer $NEXLAYER_TOKEN" \
  -F "file=@site.zip" \
  -F "name=nexlayer2-static-site" \
  -o deploy_response.json

echo "Response:"
cat deploy_response.json

if grep -q "error" deploy_response.json; then
  echo "Deployment returned an error. See deploy_response.json for details."
  exit 2
fi

echo "Deployment finished."
