#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'golang-migrate' feature with version v4.15.2.

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "migrate version" migrate -version | grep "4.15.2"

# Report result
reportResults