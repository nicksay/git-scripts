#! /bin/bash

set -e  # Stop on error.

# Run from the the script directory.
cd "$(dirname "$0")"

# Install scripts.
mkdir -p "$HOME/bin"
rsync -avh --no-perms "$PWD"/git-* "$HOME/bin/"

# Insall aliases.
if ! git config --global --get alias.new >/dev/null; then
  git config --global alias.new "!git checkout master && git checkout -b"
fi
