#!/bin/bash
# Context building hook - tracks all activities

TOOL_NAME="$1"
COMMAND="$2"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Initialize context file if it doesn't exist
CONTEXT_FILE=".claude/temp/contextbuilder.txt"
mkdir -p "$(dirname "$CONTEXT_FILE")"

if [[ ! -f "$CONTEXT_FILE" ]]; then
    cat > "$CONTEXT_FILE" << 'EOL'
# Claude Code Autonomous Development Context
# This file tracks all activities and context throughout the development process
# Generated automatically by the context building system

## Session Information
- Session started: $(date)
- Environment: Windows (WSL/Git Bash)
- Working directory: $(pwd)

## Development Progress

EOL
fi

# Append activity
echo "### [$TIMESTAMP] $TOOL_NAME Activity" >> "$CONTEXT_FILE"
echo "Command: $COMMAND" >> "$CONTEXT_FILE"
echo "Status: Executed" >> "$CONTEXT_FILE"
echo "" >> "$CONTEXT_FILE"

# Keep context file size manageable (last 1000 lines)
tail -n 1000 "$CONTEXT_FILE" > "$CONTEXT_FILE.tmp" && mv "$CONTEXT_FILE.tmp" "$CONTEXT_FILE"

exit 0
