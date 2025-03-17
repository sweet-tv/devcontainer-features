#!/bin/bash

# This test file will be executed against a scenario devcontainer.json that
# includes the 'buf-cli' Feature with a specific version.
#
# For more information, see: https://github.com/devcontainers/cli/blob/main/docs/features/test.md
#
# This scenario tests that a specific version of buf-cli is installed correctly.

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "buf command exists" which buf
check "buf specific version" buf --version | grep "1.29.0"

# Report result
reportResults