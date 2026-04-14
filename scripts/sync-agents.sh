#!/bin/bash

# 1. Choose your master file
SOURCE_FILE="AGENTS.md"

# 2. Files used by different agents
AGENT_FILES=(
    "CLAUDE.md"
    ".cursorrules"
    ".clinerules"
    ".github/copilot-instructions.md"
)

# 3. Create the master file if it doesn't exist yet
if [ ! -f "$SOURCE_FILE" ]; then
    echo "Creating initial $SOURCE_FILE..."
    cat <<EOF > "$SOURCE_FILE"
# AI Agent Rules (Source of Truth)
- Always use TypeScript for new files.
- Prefer functional components over classes.
EOF
fi

# 4. Create symlinks for each agent
for file in "${AGENT_FILES[@]}"; do
    # Ensure directories exist (e.g., .github/)
    mkdir -p "$(dirname "$file")"

    # Backup existing real files before linking
    if [ -f "$file" ] && [ ! -L "$file" ]; then
        mv "$file" "$file.bak"
        echo "⚠️ Backed up real file to $file.bak"
    fi

    # Force create/update symbolic link
    ln -sf "$(pwd)/$SOURCE_FILE" "$file"
    echo "✅ Linked $file -> $SOURCE_FILE"
done
