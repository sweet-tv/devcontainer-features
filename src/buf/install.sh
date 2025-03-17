#!/bin/sh
set -e

echo "Activating feature 'buf'"

# The 'install.sh' entrypoint script is always executed as the root user.
#
# These following environment variables are passed in by the dev container CLI.
# For more details, see https://containers.dev/implementors/features#user-env-var
echo "The effective dev container remoteUser is '$_REMOTE_USER'"
echo "The effective dev container remoteUser's home directory is '$_REMOTE_USER_HOME'"

# Handle version input
VERSION=${VERSION:-"latest"}
echo "Installing Buf CLI version: ${VERSION}"

# Install dependencies
apt-get update
apt-get install -y curl unzip

# Set up architecture detection for appropriate binary
ARCHITECTURE=$(uname -m)
case $ARCHITECTURE in
    x86_64)
        ARCHITECTURE="x86_64"
        ;;
    aarch64|arm64)
        ARCHITECTURE="aarch64"
        ;;
    *)
        echo "Unsupported architecture: $ARCHITECTURE"
        exit 1
        ;;
esac

# Determine which version to install
if [ "${VERSION}" = "latest" ]; then
    # Get the latest version
    RELEASE_URL="https://github.com/bufbuild/buf/releases/latest/download"
else
    # Get the specified version
    RELEASE_URL="https://github.com/bufbuild/buf/releases/download/v${VERSION}"
fi

# Create a temporary directory for the download
TEMP_DIR=$(mktemp -d)
cd $TEMP_DIR

# Download and install buf
echo "Downloading Buf CLI for ${ARCHITECTURE}..."
DOWNLOAD_FILE="buf-Linux-${ARCHITECTURE}.tar.gz"
curl -fsSL -o ${DOWNLOAD_FILE} "${RELEASE_URL}/${DOWNLOAD_FILE}"
tar -xzf ${DOWNLOAD_FILE} --strip-components 1
mv ./bin/buf /usr/local/bin/

# Verify installation
echo "Verifying Buf CLI installation..."
buf --version

# Cleanup
cd -
rm -rf $TEMP_DIR

echo "Buf CLI installation complete"