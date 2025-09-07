#!/bin/bash
# Security monitoring hook - blocks dangerous commands

TOOL_NAME="$1"
COMMAND="$2"

# Define dangerous patterns
DANGEROUS_PATTERNS=(
    "rm -rf /"
    "sudo rm"
    "format"
    "fdisk"
    "mkfs"
    "dd if="
    "> /dev/"
    "chmod 777"
    "chown -R root"
)

# Check for dangerous patterns
for pattern in "${DANGEROUS_PATTERNS[@]}"; do
    if [[ "$COMMAND" == *"$pattern"* ]]; then
        echo "🚨 SECURITY ALERT: Dangerous command blocked: $pattern"
        echo "Command: $COMMAND"
        echo "If this is intentional, please run manually with confirmation."
        exit 1
    fi
done

# Log security check
echo "$(date): Security check passed for: $TOOL_NAME" >> .claude/logs/security.log
exit 0
