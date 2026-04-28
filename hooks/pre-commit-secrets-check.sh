#!/bin/bash
# Hook: PreToolUse (Bash) — when command contains "git commit"
# Scans staged files for common secret patterns.
# Exits with code 2 to block the commit if secrets are found.

# Only run on git commit commands
COMMAND="${TOOL_INPUT_COMMAND:-$1}"
if ! echo "$COMMAND" | grep -q "git commit"; then
  exit 0
fi

STAGED_FILES=$(git diff --cached --name-only 2>/dev/null)
if [ -z "$STAGED_FILES" ]; then
  exit 0
fi

FOUND=0

while IFS= read -r file; do
  if [ ! -f "$file" ]; then
    continue
  fi

  # Skip binary files
  if file "$file" | grep -q "binary"; then
    continue
  fi

  # Check for common secret patterns
  MATCHES=$(grep -nE "(sk-[a-zA-Z0-9]{20,}|AKIA[A-Z0-9]{16}|ghp_[a-zA-Z0-9]{36}|glpat-[a-zA-Z0-9\-]{20,}|-----BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY-----|xox[bpras]-[a-zA-Z0-9\-]+)" "$file" 2>/dev/null)

  if [ -n "$MATCHES" ]; then
    echo "BLOCKED: Possible secret found in $file:"
    echo "$MATCHES" | head -5
    FOUND=1
  fi
done <<< "$STAGED_FILES"

if [ "$FOUND" -eq 1 ]; then
  echo ""
  echo "Remove secrets and use environment variables instead."
  echo "If these are false positives, review manually."
  exit 2
fi
