#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOST="pieri-notebook"
HM_USER="pieri"

log() {
  printf "\n==> %s\n" "$1"
}

cd "$REPO_DIR"

log "Updating flake inputs"
nix flake update

log "Applying NixOS configuration (prefers sysup alias)"
if zsh -ic 'alias sysup >/dev/null 2>&1'; then
  zsh -ic 'sysup'
else
  echo "sysup alias not found, using nixos-rebuild fallback"
  sudo nixos-rebuild switch --flake ".#${HOST}"
fi

if command -v home-manager >/dev/null 2>&1; then
  log "Applying Home Manager (if homeConfigurations output exists)"
  if nix eval --raw ".#homeConfigurations.${HM_USER}.activationPackage.drvPath" >/dev/null 2>&1; then
    home-manager switch --flake ".#${HM_USER}"
  else
    echo "No homeConfigurations.${HM_USER} in flake; skipping separate home-manager switch"
  fi
else
  echo "home-manager command not found; skipping separate home-manager switch"
fi

log "Collecting old generations and garbage"
sudo nix-collect-garbage -d

log "Done"
