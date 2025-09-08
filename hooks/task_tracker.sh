#!/bin/bash
# Task Tracker Hook - Session End Handler
# Handles session completion and cleanup

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPT_DIR/../logs/task_tracker.log"

# Create log directory
mkdir -p "$(dirname "$LOG_FILE")"

# Log function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

SESSION_EVENT="${1:-unknown}"
STATUS="${2:-unknown}"

log "INFO: Task tracker hook called - Event: $SESSION_EVENT, Status: $STATUS"

case "$SESSION_EVENT" in
    "session_end")
        log "INFO: Session ending with status: $STATUS"
        
        # Clean up temporary files
        find /tmp -name "claude_*" -type f -mtime +1 -delete 2>/dev/null || true
        
        # Archive current session logs if they exist
        if [ -d "$SCRIPT_DIR/../logs" ]; then
            SESSION_ID=$(date +%Y%m%d_%H%M%S)
            mkdir -p "$SCRIPT_DIR/../archive/$SESSION_ID" 2>/dev/null || true
        fi
        
        log "INFO: Session cleanup completed successfully"
        ;;
    *)
        log "INFO: Unhandled session event: $SESSION_EVENT"
        ;;
esac

exit 0