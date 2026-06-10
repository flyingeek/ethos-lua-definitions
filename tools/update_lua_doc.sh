#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: $0 <lua-doc-zip-url>"
    echo "Example: $0 https://github.com/FrSkyRC/ETHOS-Feedback-Community/releases/download/26.1.0-RC4/lua-doc.zip"
    exit 1
fi

URL="$1"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
LUA_DOC_DIR="$REPO_DIR/lua-doc"
TMPDIR="$(mktemp -d)"

trap 'rm -rf "$TMPDIR"' EXIT

echo "Downloading $URL ..."
curl -fsSL -o "$TMPDIR/lua-doc.zip" "$URL"

echo "Extracting ..."
unzip -q -o "$TMPDIR/lua-doc.zip" -d "$TMPDIR/extracted"

# Find the actual content directory (may be nested under a lua-doc/ folder)
if [ -d "$TMPDIR/extracted/lua-doc" ]; then
    SRC="$TMPDIR/extracted/lua-doc"
elif [ -d "$TMPDIR/extracted/html" ]; then
    SRC="$TMPDIR/extracted/html"
else
    SRC="$TMPDIR/extracted"
fi

echo "Updating $LUA_DOC_DIR ..."
rm -rf "$LUA_DOC_DIR"
mv "$SRC" "$LUA_DOC_DIR"

echo "Done."
