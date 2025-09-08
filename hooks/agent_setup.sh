#!/usr/bin/env bash
# Global Agent Setup Hook - PreAgentInvoke
set -euo pipefail

HOOK_INPUT=$(cat)
LOG_FILE="contextbuilder.txt"

# Extract agent information
if command -v jq >/dev/null 2>&1; then
    AGENT_NAME=$(echo "$HOOK_INPUT" | jq -r '.agent_name // "unknown"')
else
    AGENT_NAME="autonomous_agent"
fi

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Set environment variables
export CLAUDE_AGENT_ROLE="$AGENT_NAME"
export AGENT_START_TIME="$TIMESTAMP"
export PROJECT_ROOT="$(pwd)"

# Create agent temp directory
AGENT_TEMP_DIR=".claude/temp/$AGENT_NAME"
mkdir -p "$AGENT_TEMP_DIR" 2>/dev/null || true
export AGENT_TEMP_DIR="$AGENT_TEMP_DIR"

# Log agent invocation
echo "[$TIMESTAMP][Orchestrator][agent_invoke][$AGENT_NAME][Autonomous agent started][Agent initialized][In Progress]" >> "$LOG_FILE"

exit 0
