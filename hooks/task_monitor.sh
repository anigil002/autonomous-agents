#!/usr/bin/env bash
# Global Task Monitor Hook - PostAgentComplete
set -euo pipefail

HOOK_INPUT=$(cat)
LOG_FILE="contextbuilder.txt"
MASTER_PLAN="master_plan.md"

# Extract completion information
if command -v jq >/dev/null 2>&1; then
    AGENT_NAME=$(echo "$HOOK_INPUT" | jq -r '.agent_name // "unknown"')
    COMPLETION_STATUS=$(echo "$HOOK_INPUT" | jq -r '.status // "completed"')
else
    AGENT_NAME="autonomous_agent"
    COMPLETION_STATUS="completed"
fi

TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Log completion
echo "[$TIMESTAMP][Orchestrator][agent_complete][$AGENT_NAME][Agent task completed][Autonomous workflow step finished][$COMPLETION_STATUS]" >> "$LOG_FILE"

# Check for task completion marker
TASK_COMPLETED=false
if [ -f "$LOG_FILE" ]; then
    if tail -n 50 "$LOG_FILE" | grep -q "TaskGroup-Completed" && tail -n 50 "$LOG_FILE" | grep -q "\[$AGENT_NAME\]"; then
        TASK_COMPLETED=true
    fi
fi

# Update master plan if exists
if [ "$TASK_COMPLETED" = true ] && [ -f "$MASTER_PLAN" ]; then
    # Mark first incomplete task as complete
    sed -i '0,/- \[ \]/{s/- \[ \]/- [X]/}' "$MASTER_PLAN" 2>/dev/null || true
    
    # Check if all tasks complete
    INCOMPLETE_TASKS=$(grep -c '\- \[ \]' "$MASTER_PLAN" 2>/dev/null || echo "0")
    if [ "$INCOMPLETE_TASKS" = "0" ]; then
        echo "[$TIMESTAMP][Orchestrator][project_complete][all_tasks][All autonomous tasks completed][Ready for final report][ProjectComplete]" >> "$LOG_FILE"
        echo "AUTONOMOUS DEVELOPMENT COMPLETE! Run '/generate_report' for final deliverables." > .claude/project_complete.txt
    fi
fi

# Cleanup
rm -rf ".claude/temp/$AGENT_NAME" 2>/dev/null || true

exit 0
