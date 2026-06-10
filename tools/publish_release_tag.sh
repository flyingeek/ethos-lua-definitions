#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: $0 <release-tag>"
    echo "Example: $0 release/26.1.0-RC1"
    exit 1
fi

TAG="$1"
VERSION="${TAG#release/}"
CLEAN_VERSION="$(printf '%s' "$VERSION" | tr -cd '[:alnum:].-')"
WORKFLOW_BRANCH="update-ethos-addon-${CLEAN_VERSION}"
WORKFLOW_REPO="https://github.com/flyingeek/LLS-Addons.git"

if ! git diff-index --quiet HEAD --; then
    echo "Error: git status is not clean"
    exit 1
fi

if git rev-parse --verify --quiet "$TAG" >/dev/null; then
    echo "Error: tag $TAG already exists. To delete locally and on origin: git tag -d $TAG && git push origin :$TAG"
    exit 1
fi

if git ls-remote --exit-code --heads "$WORKFLOW_REPO" "$WORKFLOW_BRANCH" >/dev/null; then
    echo "Error: workflow branch $WORKFLOW_BRANCH already exists in flyingeek/LLS-Addons. To delete it: git push git@github.com:flyingeek/LLS-Addons.git --delete $WORKFLOW_BRANCH"
    exit 1
fi

git tag "$TAG"
git push origin "$TAG"
