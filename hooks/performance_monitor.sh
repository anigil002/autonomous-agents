#!/bin/bash
# Performance Monitor Hook
# Monitors tool execution performance and resource usage

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPT_DIR/../logs/performance_monitor.log"

# Create log directory
mkdir -p "$(dirname "$LOG_FILE")"

# Log function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

TOOL_NAME="${1:-unknown}"
ARGS="${2:-}"
START_TIME="${3:-$(date +%s)}"
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

log "INFO: Performance monitoring - Tool: $TOOL_NAME, Duration: ${DURATION}s"

# Only log if duration is significant (> 1 second)
if [ $DURATION -gt 1 ]; then
    # Get system metrics (simplified for cross-platform compatibility)
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | sed 's/%us,//' 2>/dev/null || echo "0")
    MEMORY_USAGE=$(free -m 2>/dev/null | grep '^Mem:' | awk '{printf "%.1f", ($3/$2)*100}' || echo "0")
    
    log "PERF: Tool=$TOOL_NAME Duration=${DURATION}s CPU=${CPU_USAGE}% Memory=${MEMORY_USAGE}%"
    
    # Log performance warning if duration is very long
    if [ $DURATION -gt 30 ]; then
        log "WARN: Long execution time for $TOOL_NAME: ${DURATION}s"
    fi
fi

exit 0