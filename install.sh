#! /bin/bash

set -e  # Stop on error.

# Run from the the script directory.
cd "$(dirname "$0")"

echo "Installing scripts..."
mkdir -p "$HOME/bin"
rsync -avh --no-perms "$PWD"/git-* "$HOME/bin/"
echo "Done."

echo "Installing aliases..."
if ! git config --global --get alias.new >/dev/null; then
  git config --global alias.new "!git checkout master && git checkout -b"
fi
if ! git config --global --get alias.done >/dev/null; then
  git config --global alias.done "!git checkout master && git sync && git tidy"
fi
echo "Done."
