#!/bin/bash
cd $(dirname "$0")
source test-utils.sh

# Template specific tests
check "distro" cat /etc/os-release
check "hugo" hugo version
check "node" node -v
#check "greeting" [ $(cat /usr/local/etc/greeting.txt | grep hey) ]

# Report result
reportResults
