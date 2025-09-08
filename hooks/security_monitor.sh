#!/bin/bash
# Enhanced Security Monitor Hook
# Validates security before file edits to prevent credential exposure and security vulnerabilities

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$SCRIPT_DIR/../logs/security_monitor.log"
CONFIG_FILE="$SCRIPT_DIR/../config/security_rules.json"

# Create log directory if it doesn't exist
mkdir -p "$(dirname "$LOG_FILE")"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Get file path from arguments
FILE_PATH="${1:-}"
OPERATION="${2:-edit}"

if [ -z "$FILE_PATH" ]; then
    log "ERROR: No file path provided to security monitor"
    exit 1
fi

log "INFO: Security monitoring for $OPERATION on $FILE_PATH"

# Security check functions
check_sensitive_patterns() {
    local file="$1"
    local violations=0
    
    # Define sensitive patterns
    declare -a SENSITIVE_PATTERNS=(
        "password\s*=\s*[\"'][^\"']+[\"']"
        "api_key\s*=\s*[\"'][^\"']+[\"']"
        "secret\s*=\s*[\"'][^\"']+[\"']"
        "token\s*=\s*[\"'][^\"']+[\"']"
        "private_key\s*=\s*[\"'][^\"']+[\"']"
        "database_url\s*=\s*[\"'][^\"']+[\"']"
        "-----BEGIN PRIVATE KEY-----"
        "-----BEGIN RSA PRIVATE KEY-----"
        "AKIA[0-9A-Z]{16}"  # AWS Access Key
        "ya29\.[0-9A-Za-z\-_]+"  # Google OAuth
        "sk-[a-zA-Z0-9]{48}"  # OpenAI API Key
        "[0-9a-f]{32}"  # Generic 32-char hash
    )
    
    for pattern in "${SENSITIVE_PATTERNS[@]}"; do
        if grep -Pq "$pattern" "$file" 2>/dev/null; then
            log "WARNING: Sensitive pattern detected: $pattern in $file"
            ((violations++))
        fi
    done
    
    return $violations
}

check_file_permissions() {
    local file="$1"
    
    # Check if file has overly permissive permissions
    if [ -f "$file" ]; then
        local perms=$(stat -f "%Lp" "$file" 2>/dev/null || stat -c "%a" "$file" 2>/dev/null)
        if [ "$perms" -gt 644 ]; then
            log "WARNING: File $file has permissive permissions: $perms"
            return 1
        fi
    fi
    
    return 0
}

check_dangerous_operations() {
    local file="$1"
    local violations=0
    
    # Check for dangerous shell commands in scripts
    if [[ "$file" =~ \.(sh|bash|zsh)$ ]]; then
        declare -a DANGEROUS_COMMANDS=(
            "rm\s+-rf\s+/"
            "chmod\s+777"
            "eval\s+\$"
            "curl\s+.*\|\s*bash"
            "wget\s+.*\|\s*sh"
            "sudo\s+rm"
            "dd\s+if="
            "mkfs\."
        )
        
        for cmd in "${DANGEROUS_COMMANDS[@]}"; do
            if grep -Pq "$cmd" "$file" 2>/dev/null; then
                log "ERROR: Dangerous command detected: $cmd in $file"
                ((violations++))
            fi
        done
    fi
    
    return $violations
}

check_sql_injection_patterns() {
    local file="$1"
    local violations=0
    
    # Check for potential SQL injection vulnerabilities
    declare -a SQL_PATTERNS=(
        "SELECT\s+.*\s+FROM\s+.*\s+WHERE\s+.*\+.*"
        "INSERT\s+INTO\s+.*VALUES\s*\(.*\+.*\)"
        "UPDATE\s+.*SET\s+.*=.*\+.*WHERE"
        "DELETE\s+FROM\s+.*WHERE\s+.*\+.*"
        "UNION\s+SELECT"
        "OR\s+1\s*=\s*1"
        "'\s*OR\s*'"
    )
    
    for pattern in "${SQL_PATTERNS[@]}"; do
        if grep -Piq "$pattern" "$file" 2>/dev/null; then
            log "WARNING: Potential SQL injection pattern: $pattern in $file"
            ((violations++))
        fi
    done
    
    return $violations
}

check_xss_patterns() {
    local file="$1"
    local violations=0
    
    # Check for potential XSS vulnerabilities in web files
    if [[ "$file" =~ \.(html|js|jsx|ts|tsx|php)$ ]]; then
        declare -a XSS_PATTERNS=(
            "innerHTML\s*=\s*.*\+.*"
            "document\.write\s*\(.*\+.*\)"
            "eval\s*\(.*\+.*\)"
            "setTimeout\s*\(.*\+.*\)"
            "setInterval\s*\(.*\+.*\)"
        )
        
        for pattern in "${XSS_PATTERNS[@]}"; do
            if grep -Piq "$pattern" "$file" 2>/dev/null; then
                log "WARNING: Potential XSS vulnerability: $pattern in $file"
                ((violations++))
            fi
        done
    fi
    
    return $violations
}

validate_json_security() {
    local file="$1"
    local violations=0
    
    if [[ "$file" =~ \.json$ ]]; then
        # Check for sensitive keys in JSON files
        if jq -e 'paths(scalars) as $p | $p[-1] | test("password|secret|key|token"; "i")' "$file" >/dev/null 2>&1; then
            log "WARNING: Sensitive keys found in JSON file: $file"
            ((violations++))
        fi
        
        # Check for overly permissive CORS settings
        if jq -e '.cors.origin == "*"' "$file" >/dev/null 2>&1; then
            log "WARNING: Overly permissive CORS configuration in: $file"
            ((violations++))
        fi
    fi
    
    return $violations
}

check_dependency_security() {
    local file="$1"
    local violations=0
    
    # Check package.json for known vulnerable dependencies
    if [[ "$file" == "package.json" ]]; then
        if command -v npm >/dev/null 2>&1; then
            if npm audit --audit-level=critical --json 2>/dev/null | jq -e '.vulnerabilities | length > 0' >/dev/null 2>&1; then
                log "ERROR: Critical vulnerabilities found in dependencies"
                ((violations++))
            fi
        fi
    fi
    
    # Check requirements.txt for known vulnerable Python packages
    if [[ "$file" == "requirements.txt" ]]; then
        if command -v safety >/dev/null 2>&1; then
            if ! safety check -r "$file" >/dev/null 2>&1; then
                log "ERROR: Vulnerable Python packages detected in requirements.txt"
                ((violations++))
            fi
        fi
    fi
    
    return $violations
}

# Main security validation
main() {
    local total_violations=0
    
    # Skip check for certain file types
    if [[ "$FILE_PATH" =~ \.(log|tmp|cache|lock)$ ]]; then
        log "INFO: Skipping security check for $FILE_PATH (excluded file type)"
        exit 0
    fi
    
    # Skip check for files in certain directories
    if [[ "$FILE_PATH" =~ (node_modules|\.git|dist|build|coverage)/ ]]; then
        log "INFO: Skipping security check for $FILE_PATH (excluded directory)"
        exit 0
    fi
    
    # Perform security checks
    if [ -f "$FILE_PATH" ] || [ "$OPERATION" = "write" ]; then
        log "INFO: Running security validation on $FILE_PATH"
        
        # Check for sensitive patterns
        if ! check_sensitive_patterns "$FILE_PATH"; then
            ((total_violations += $?))
        fi
        
        # Check file permissions
        if ! check_file_permissions "$FILE_PATH"; then
            ((total_violations += $?))
        fi
        
        # Check for dangerous operations
        if ! check_dangerous_operations "$FILE_PATH"; then
            ((total_violations += $?))
        fi
        
        # Check for SQL injection patterns
        if ! check_sql_injection_patterns "$FILE_PATH"; then
            ((total_violations += $?))
        fi
        
        # Check for XSS patterns
        if ! check_xss_patterns "$FILE_PATH"; then
            ((total_violations += $?))
        fi
        
        # Validate JSON security
        if ! validate_json_security "$FILE_PATH"; then
            ((total_violations += $?))
        fi
        
        # Check dependency security
        if ! check_dependency_security "$FILE_PATH"; then
            ((total_violations += $?))
        fi
        
        # Report results
        if [ $total_violations -gt 0 ]; then
            log "ERROR: Security validation failed with $total_violations violations for $FILE_PATH"
            echo "Security validation failed: $total_violations violations detected in $FILE_PATH"
            echo "Check $LOG_FILE for details"
            
            # For critical files, block the operation
            if [[ "$FILE_PATH" =~ \.(env|key|pem|p12|pfx)$ ]]; then
                log "CRITICAL: Blocking operation on sensitive file type: $FILE_PATH"
                exit 1
            fi
            
            # For other files, warn but allow
            exit 0
        else
            log "INFO: Security validation passed for $FILE_PATH"
            exit 0
        fi
    else
        log "INFO: File $FILE_PATH does not exist yet, skipping validation"
        exit 0
    fi
}

# Trap to ensure cleanup on exit
trap 'log "INFO: Security monitor hook completed for $FILE_PATH"' EXIT

# Run main function
main "$@"