#!/bin/bash
# Context Builder Hook
# Tracks all development activities and builds comprehensive project context

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTEXT_DIR="$SCRIPT_DIR/../context"
LOG_FILE="$SCRIPT_DIR/../logs/context_builder.log"
ACTIVITY_LOG="$CONTEXT_DIR/activity.jsonl"

# Create directories if they don't exist
mkdir -p "$CONTEXT_DIR" "$(dirname "$LOG_FILE")"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Get operation details
OPERATION="${1:-unknown}"
TARGET="${2:-}"
USER="${USER:-$(whoami)}"
SESSION_ID="${CLAUDE_SESSION_ID:-$(date +%s)}"

log "INFO: Context tracking for $OPERATION on $TARGET"

# Main context building function
main() {
    log "INFO: Starting context building for $OPERATION"
    
    # Skip context building for certain operations
    if [[ "$TARGET" =~ \.(log|tmp|cache)$ ]]; then
        log "INFO: Skipping context building for $TARGET (excluded file type)"
        exit 0
    fi
    
    # Record activity
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%S.%3NZ")
    local record="{\"timestamp\":\"$timestamp\",\"session\":\"$SESSION_ID\",\"operation\":\"$OPERATION\",\"target\":\"$TARGET\"}"
    echo "$record" >> "$ACTIVITY_LOG"
    
    log "INFO: Context building completed for $OPERATION"
    exit 0
}

# Run main function
main "$@"