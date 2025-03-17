#!/bin/sh
set -e

echo "Activating feature 'golang-migrate'"

# The 'install.sh' entrypoint script is always executed as the root user.
#
# These following environment variables are passed in by the dev container CLI.
# For more details, see https://containers.dev/implementors/features#user-env-var
echo "The effective dev container remoteUser is '$_REMOTE_USER'"
echo "The effective dev container remoteUser's home directory is '$_REMOTE_USER_HOME'"

# Install dependencies
apt-get update
apt-get install -y curl tar

# Handle version input
VERSION=${VERSION:-"latest"}

# Determine release URL based on version
if [ "${VERSION}" = "latest" ]; then
    RELEASE_URL="https://github.com/golang-migrate/migrate/releases/latest/download"
else
    # Ensure version has v prefix
    if [ "${VERSION:0:1}" != "v" ]; then
        VERSION="v${VERSION}"
    fi
    RELEASE_URL="https://github.com/golang-migrate/migrate/releases/download/${VERSION}"
fi

echo "Installing golang-migrate CLI version: ${VERSION}"

# Set up architecture detection for appropriate binary
ARCHITECTURE=$(uname -m)
case $ARCHITECTURE in
    x86_64)
        ARCH="amd64"
        ;;
    aarch64|arm64)
        ARCH="arm64"
        ;;
    *)
        echo "Unsupported architecture: $ARCHITECTURE"
        exit 1
        ;;
esac

# Set OS
OS="linux"

# Create a temporary directory for the download
TEMP_DIR=$(mktemp -d)
cd $TEMP_DIR

# Download and install golang-migrate
echo "Downloading golang-migrate CLI..."
curl -L "${RELEASE_URL}/migrate.${OS}-${ARCH}.tar.gz" | tar xvz

# Move the binary to a location in PATH
mv ./migrate /usr/local/bin/
chmod +x /usr/local/bin/migrate

# Verify installation
echo "Verifying golang-migrate CLI installation..."
migrate -version

# Cleanup
cd -
rm -rf $TEMP_DIR

echo "golang-migrate CLI installation complete"