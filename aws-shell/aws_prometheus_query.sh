#!/bin/sh

urlencode() {
  python3 -c 'import sys,urllib.parse; print(urllib.parse.quote(sys.argv[1], safe=""))' "$1"
}

awscurl -X POST --service aps \
  --region $AWS_REGION \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "query=$(urlencode "$1")" \
  "https://aps-workspaces.${AWS_REGION}.amazonaws.com/workspaces/${AWS_PROMETHEUS_WORKSPACE}/api/v1/query"