#!/bin/bash
# Performance monitoring hook

TOOL_NAME="$1"  
START_TIME="$3"
END_TIME=$(date +%s.%N)

if [[ -n "$START_TIME" ]]; then
    DURATION=$(echo "$END_TIME - $START_TIME" | bc 2>/dev/null || echo "N/A")
    
    # Log performance data
    PERF_LOG=".claude/logs/performance.log"
    mkdir -p "$(dirname "$PERF_LOG")"
    
    echo "$(date '+%Y-%m-%d %H:%M:%S'),$TOOL_NAME,$DURATION" >> "$PERF_LOG"
    
    # Alert for slow operations (>30 seconds)
    if (( $(echo "$DURATION > 30" | bc -l 2>/dev/null) )); then
        echo "⚠️  Slow operation detected: $TOOL_NAME took ${DURATION}s"
    fi
fi

exit 0
