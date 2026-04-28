#!/bin/bash
# Hook: PostToolUse (Write|Edit)
# Warns about console.log / print() left in code.
# Non-blocking — just prints a warning.

FILE_PATH="${TOOL_INPUT_FILE_PATH:-$1}"

if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

# Skip test files and config files
case "$FILE_PATH" in
  *.test.* | *.spec.* | *_test.* | */test_* | *.config.* | *.json)
    exit 0
    ;;
esac

MATCHES=""

case "$FILE_PATH" in
  *.ts | *.tsx | *.js | *.jsx)
    MATCHES=$(grep -n "console\.log\b" "$FILE_PATH" 2>/dev/null)
    ;;
  *.py)
    MATCHES=$(grep -n "^\s*print(" "$FILE_PATH" 2>/dev/null)
    ;;
esac

if [ -n "$MATCHES" ]; then
  echo "NOTE: Debug logging found in $FILE_PATH:"
  echo "$MATCHES" | head -3
  echo "Use a proper logger instead of console.log/print()."
fi
