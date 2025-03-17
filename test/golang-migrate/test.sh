#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'golang-migrate' feature with no options.

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "migrate version" migrate -version | grep "migrate version"

# Report result
reportResults