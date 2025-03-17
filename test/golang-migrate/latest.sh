#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'golang-migrate' feature with default options.

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
# Just check that migrate is installed and returns a version
check "migrate is installed" migrate -version
check "migrate version format" migrate -version | grep -E "^[0-9]+\.[0-9]+\.[0-9]+$"

# Report result
reportResults