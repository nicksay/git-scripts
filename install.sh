#! /bin/bash

set -e  # Stop on error.

# Run from the the script directory.
cd "$(dirname "$0")"

mkdir -p "$HOME/bin"

rsync -avh --no-perms "$PWD"/git-* "$HOME/bin/"
