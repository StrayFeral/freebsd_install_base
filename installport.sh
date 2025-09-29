#!/usr/local/bin/bash
set -e

PORT="$1"
if [ -z "$PORT" ]; then
    echo "Usage: $0 category/portname"
    exit 1
fi

# Ensure PACKAGES is set (adjust if you prefer another dir)
PACKAGES_DIR="/usr/ports/packages"
export PACKAGES="$PACKAGES_DIR"

cd "/usr/ports/$PORT"

echo ">>> Building $PORT and dependencies..."
make -DBATCH package-recursive

echo ">>> Installing $PORT..."
# pick the latest built package for this port
PKGFILE=$(ls -t "$PACKAGES_DIR/All/"$(basename "$PORT")-*.pkg | head -n1)

pkg add -A "$PKGFILE"

echo ">>> Done. $PORT and dependencies installed."
