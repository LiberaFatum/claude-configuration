#!/bin/bash
# Hook: PostToolUse (Write|Edit)
# Warns if a file exceeds 400 lines after editing.
# Non-blocking — just prints a warning.

FILE_PATH="${TOOL_INPUT_FILE_PATH:-$1}"

if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

LINE_COUNT=$(wc -l < "$FILE_PATH")

if [ "$LINE_COUNT" -gt 800 ]; then
  echo "WARNING: $FILE_PATH is $LINE_COUNT lines (hard limit: 800). Split this file into smaller modules."
elif [ "$LINE_COUNT" -gt 400 ]; then
  echo "NOTE: $FILE_PATH is $LINE_COUNT lines. Consider splitting if it grows further."
fi
