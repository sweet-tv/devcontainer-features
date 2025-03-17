#!/bin/bash

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature name
check "buf command exists" command -v buf
check "buf version" buf --version | grep "1.20.0"

# Report result
reportResults