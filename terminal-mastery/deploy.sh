#!/usr/bin/env bash

set -euo pipefail

BRANCH="${1:-main}"

if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: not inside a git repository."
    exit 1
fi

if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "Error: you have uncommitted changes. Commit or stash them first."
    exit 1
fi

echo "Running tests..."
npm test

echo "Building..."
npm run build

echo "Pushing to '$BRANCH'..."
git push origin "$BRANCH"

echo "Deploy complete!"