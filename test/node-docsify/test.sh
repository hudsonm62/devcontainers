#!/bin/bash
cd $(dirname "$0")
source test-utils.sh

# Template specific tests
check "distro" cat /etc/os-release
check "node" node -v
check "docsify" docsify-cli -v

# Report result
reportResults
