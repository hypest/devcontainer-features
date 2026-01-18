# Dev Container Feature: Git Host Credentials

A Dev Container Feature that installs Git and SSH client to enable seamless credential bridging from your host VS Code environment.

Works with Alpine, Debian, Ubuntu, RHEL, Fedora, and Arch-based containers.

## Usage

Add this feature to any `devcontainer.json`:

```json
{
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "features": {
    "ghcr.io/hypest/devcontainer-github-user/git-host-credentials:1": {}
  }
}
```

## How to Add in VS Code

1. Open the Command Palette (`F1` or `Ctrl+Shift+P`)
2. Run: **Dev Containers: Configure Container Features**
3. Search for "Git Host Credentials" or enter the feature ID: `ghcr.io/hypest/devcontainer-github-user/git-host-credentials`
4. Select it and rebuild your container

## Publishing

This feature is automatically published to GitHub Container Registry (GHCR) on every push to `main` via GitHub Actions.
