#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

set -euo pipefail

SUBDIRS=$(echo */)
for currDir in $SUBDIRS; do
  currTagsFile="${currDir}images/tags.txt"
  if [ -e "$currTagsFile" ]; then
    while read -r line; do
        docker push "$line"
    done < "$currTagsFile"
  fi
done
