#!/bin/bash
set -e

# Beads Devcontainer Feature Installation Script
# This script installs Beads issue tracker and optionally configures it

echo "Installing Beads issue tracker..."

# Get options from devcontainer feature
VERSION="${VERSION:-latest}"
INSTALL_HOOKS="${INSTALLHOOKS:-true}"
RUN_DOCTOR="${RUNDOCTOR:-true}"
SOCKET_PATH="${SOCKETPATH:-/tmp/bd.sock}"

# Install Beads using the official installation script
echo "Downloading and installing Beads ${VERSION}..."
curl -fsSL https://raw.githubusercontent.com/steveyegge/beads/main/scripts/install.sh | bash

# Verify bd command is available
if ! command -v bd &> /dev/null; then
    echo "ERROR: Beads installation failed - 'bd' command not found"
    exit 1
fi

echo "Beads installed successfully!"
echo "BD_SOCKET set to: ${SOCKET_PATH}"

# Note: Migration and hooks will be handled in postCreateCommand since they require
# the repository to be cloned and available

cat << 'EOF' > /usr/local/bin/beads-setup
#!/bin/bash
# Beads post-clone setup script
# Run this after cloning a repository to set up Beads

set -e

echo "Setting up Beads for this repository..."

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Not in a git repository. Skipping Beads setup."
    exit 0
fi

# Run migrations
echo "Running Beads migrations..."
bd migrate || echo "Note: Migration may have issues if .beads directory doesn't exist yet"
bd migrate --update-repo-id || true

# Install hooks if requested
if [ "$1" = "--install-hooks" ] || [ "${INSTALL_HOOKS}" = "true" ]; then
    echo "Installing Beads git hooks..."
    bd hooks install || echo "Warning: Could not install hooks"
fi

# Run doctor if requested
if [ "$1" = "--run-doctor" ] || [ "${RUN_DOCTOR}" = "true" ]; then
    echo "Running Beads doctor to validate setup..."
    echo 'Y' | bd doctor --fix || echo "Warning: Doctor check had issues"
fi

# Sync with remote
echo "Syncing Beads with remote..."
bd sync || echo "Warning: Could not sync with remote (maybe no remote is configured yet)"

echo "Beads setup complete!"
echo ""
echo "Quick start:"
echo "  bd ready              # Find available work"
echo "  bd show <id>          # View issue details"
echo "  bd update <id> --status in_progress  # Claim work"
echo "  bd close <id>         # Complete work"
echo "  bd sync               # Sync with git"
EOF

chmod +x /usr/local/bin/beads-setup

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✓ Beads feature installed successfully!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "To complete setup after cloning your repository, run:"
echo "  beads-setup"
echo ""
echo "Or add this to your devcontainer.json postCreateCommand:"
echo "  \"postCreateCommand\": \"beads-setup\""
echo ""
