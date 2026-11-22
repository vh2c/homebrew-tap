#!/usr/bin/env bash
# Updates Casks/ai-gauge.rb to the latest (or specified) release tag from vh2c/ai-gauge.
# Usage: ./scripts/update-cask.sh [v1.2.1]
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TAP_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
CASK_FILE="${TAP_DIR}/Casks/ai-gauge.rb"
REPO="vh2c/ai-gauge"
ZIP_NAME="AI-Gauge-macOS-vh2c.zip"

TAG="${1:-}"
if [ -z "${TAG}" ]; then
  TAG="$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest" \
    | python3 -c 'import sys, json; print(json.load(sys.stdin)["tag_name"])')"
fi

VERSION="${TAG#v}"
SUMS_URL="https://github.com/${REPO}/releases/download/${TAG}/SHA256SUMS.txt"

echo "Fetching SHA256SUMS.txt for ${TAG}..."
SHA256="$(curl -fsSL "${SUMS_URL}" | awk -v f="${ZIP_NAME}" '($2==f || $2=="*"f) {print $1; exit}')"

if [ -z "${SHA256}" ]; then
  echo "Error: could not find ${ZIP_NAME} in ${SUMS_URL}" >&2
  exit 1
fi

python3 - "${CASK_FILE}" "${VERSION}" "${SHA256}" <<'PYEOF'
import re, sys

cask_path, version, sha256 = sys.argv[1:4]
text = open(cask_path, encoding="utf-8").read()
text, n_ver = re.subn(r'^(\s*version\s+)"[^"]+"', rf'\1"{version}"', text, count=1, flags=re.M)
text, n_sha = re.subn(r'^(\s*sha256\s+)"[^"]+"', rf'\1"{sha256}"', text, count=1, flags=re.M)

if n_ver != 1 or n_sha != 1:
    raise SystemExit(f"Failed to replace version/sha256 in {cask_path}")

open(cask_path, "w", encoding="utf-8").write(text)
PYEOF

ruby -c "${CASK_FILE}"
echo "Updated ${CASK_FILE} -> version ${VERSION}, sha256 ${SHA256}"
