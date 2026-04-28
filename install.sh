#!/usr/bin/env bash
set -e

echo "Installing sysupdate-cli..."

# Copy binary
sudo cp bin/sysupdate /usr/local/bin/sysupdate
sudo chmod +x /usr/local/bin/sysupdate

# Create lib directory
sudo mkdir -p /usr/local/lib/sysupdate

# Copy all libraries
sudo cp -r lib/* /usr/local/lib/sysupdate/

echo "✅ Installed successfully"

echo "Run with: sudo sysupdate"
