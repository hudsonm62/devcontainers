#!/bin/bash
TEMPLATE_ID="$1"
set -e

SRC_DIR="/tmp/${TEMPLATE_ID}"

if [ -z "$TEMPLATE_ID" ]; then
  echo "Error: TEMPLATE_ID is not set or empty."
  exit 1
fi

cp -R "src/${TEMPLATE_ID}" "${SRC_DIR}"
echo "Running Smoke Test"

ID_LABEL="test-container=${TEMPLATE_ID}"

npx devcontainer exec --workspace-folder "${SRC_DIR}" --id-label ${ID_LABEL} /bin/sh -c 'set -e && if [ -f "test-project/test.sh" ]; then cd test-project && if [ "$(id -u)" = "0" ]; then chmod +x test.sh; else sudo chmod +x test.sh; fi && ./test.sh; else ls -a; fi'

# Clean up
docker rm -f $(docker container ls -f "label=${ID_LABEL}" -q)
rm -rf "${SRC_DIR}"
