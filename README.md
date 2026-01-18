# Dev Container Features

A collection of Dev Container Features for enhancing your development environment.

## Git Credential Bridge

Automatically bridges your host's Git and SSH credentials into the container. Your GitHub user logged in VS Code becomes your git user - push, pull, and clone without reconfiguring.

Works with Alpine, Debian, Ubuntu, RHEL, Fedora, and Arch-based containers.

## Usage

Add this feature to any `devcontainer.json`:

```json
{
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "features": {
    "ghcr.io/hypest/devcontainer-features/git-host-credentials:1": {}
  }
}
```

## How to Add in VS Code

1. Open the Command Palette (`F1` or `Ctrl+Shift+P`)
2. Run: **Dev Containers: Configure Container Features**
3. Search for "Git Credential Bridge" or enter the feature ID: `ghcr.io/hypest/devcontainer-features/git-host-credentials`
4. Select it and rebuild your container

## Publishing

This feature is automatically published to GitHub Container Registry (GHCR) on every push to `main` via GitHub Actions.
