#! /bin/sh

set -euo pipefail

ENTRYPOINT_CONTENT=$(aws ssm get-parameter \
  --name "${SSM_ENTRYPOINT_PATH}" \
  --with-decryption \
  --query "Parameter.Value" \
  --output text)

if [ -z "${ENTRYPOINT_CONTENT}" ]; then
  echo "Error: Retrieved no entrypoint content from SSM path '${SSM_ENTRYPOINT_PATH}'"
  exit 1
fi

echo "${ENTRYPOINT_CONTENT}" > /tmp/entrypoint.sh

chmod 700 /tmp/entrypoint.sh

exec sh /tmp/entrypoint.sh "$@"