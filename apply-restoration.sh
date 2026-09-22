#!/usr/bin/env bash
# apply-restoration.sh
# Copy the restored official plugin layer into a ZCode resources directory.
#
# Usage:
#   ./apply-restoration.sh /path/to/ZCode/resources
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 /path/to/ZCode/resources" >&2
  exit 1
fi

TARGET="$1"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$HERE/restored"

[ -d "$SRC" ]    || { echo "restored/ not found next to this script." >&2; exit 1; }
[ -d "$TARGET" ] || { echo "Target resources dir not found: $TARGET" >&2; exit 1; }

echo "[1/3] Copying plugins -> $TARGET/glm/packages/"
mkdir -p "$TARGET/glm/packages"
cp -R "$SRC/glm/packages/." "$TARGET/glm/packages/"

echo "[2/3] Copying cua-helper -> $TARGET/tools/cua-helper/"
mkdir -p "$TARGET/tools"
cp -R "$SRC/tools/cua-helper" "$TARGET/tools/"

echo "[3/3] Done."
ls -1 "$TARGET/glm/packages"