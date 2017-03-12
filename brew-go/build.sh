#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/../versions.sh"

set -euo pipefail

cd "$SCRIPT_DIR"
mkdir -p "images"
tag="nmiyake/go:brew-go-t${CIRCLE_BUILD_NUM}"
docker build -t "${tag}" -f "Dockerfile" .
echo "${tag}" > "images/tags.txt"
