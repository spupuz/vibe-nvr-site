#!/bin/bash
set -e
REPO_NAME=$(basename -s .git $(git config --get remote.origin.url) 2>/dev/null || basename "$PWD")
if [[ "$REPO_NAME" == "VibeNVR-site" || "$REPO_NAME" == "vibe-nvr-site" ]]; then
  DEFAULT_BRANCH="main"
elif [[ "$REPO_NAME" == "vibenvr-telemetry-worker" ]]; then
  DEFAULT_BRANCH="master"
else
  echo "Error: This workflow can only be used for the site or telemetry repositories."
  exit 1
fi

git fetch origin
git checkout $DEFAULT_BRANCH
git pull origin $DEFAULT_BRANCH

LAST_TAG=$(git tag --sort=-v:refname | head -1 || true)
LAST_TAG=${LAST_TAG:-v1.0.0}

NEW_VERSION=$(node -e '
const [tag] = process.argv.slice(1);
const [maj, minor, patch] = tag.replace(/^v/i, "").split(".").map(Number);
console.log(`v${maj}.${minor}.${patch + 1}`);
' "$LAST_TAG")

VER_NUM=${NEW_VERSION#v}
git checkout -b "release/$NEW_VERSION"

echo "Releasing $NEW_VERSION on $REPO_NAME"
