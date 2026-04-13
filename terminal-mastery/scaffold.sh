#!/usr/bin/env bash

# -e - exit on error, -u - treat unset variables as errors, -o pipefail - catch errors inside those pipes too
set -euo pipefail

# usage check
if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <project-name>"
    exit 1
fi

# create directory
PROJECT_NAME="$1"
mkdir "$PROJECT_NAME"
cd "$PROJECT_NAME"

# initialize git
git init
git branch -M main

# create README
cat > README.md <<EOF
# $PROJECT_NAME

TODO: describle your project here
EOF

# .gitignore
cat > .gitignore <<EOF
.env
*.log
.DS_Store
EOF

# initial commit
git add .
git commit -m "Initial commit"

echo "Project '$PROJECT_NAME' created at $(pwd)"
