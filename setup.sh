#!/bin/bash
# claude-configuration / setup.sh
# Portable Claude Code configuration for development teams.
# Idempotent — safe to run multiple times.
#
# Usage:
#   bash setup.sh                          # Standard install (rules, agents, commands)
#   bash setup.sh --full                   # Standard + skills, MCP, hooks
#   bash setup.sh --with-hooks             # Standard + hooks only
#   bash setup.sh --project <type>         # Standard + copy CLAUDE.md template to current dir
#   bash setup.sh --solidity               # Include Solidity rules
#
# Project types: real-estate, song-gift, eshop, defi

set -e

# === CONFIG ===
REPO_URL="${REPO_URL:-https://github.com/LiberaFatum/claude-configuration}"
WORK_DIR="$HOME/.cache/claude-configuration"
CLAUDE_DIR="$HOME/.claude"

# === FLAGS ===
FULL=false
WITH_HOOKS=false
WITH_SOLIDITY=false
PROJECT_TYPE=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --full)
      FULL=true
      WITH_HOOKS=true
      shift
      ;;
    --with-hooks)
      WITH_HOOKS=true
      shift
      ;;
    --solidity)
      WITH_SOLIDITY=true
      shift
      ;;
    --project)
      PROJECT_TYPE="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      echo "Usage: bash setup.sh [--full] [--with-hooks] [--solidity] [--project <type>]"
      exit 1
      ;;
  esac
done

# === PREREQUISITES ===
echo "Checking prerequisites..."

if ! command -v claude >/dev/null 2>&1; then
  echo "ERROR: Claude Code is not installed."
  echo "  Install: https://docs.anthropic.com/en/docs/claude-code/overview"
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo "ERROR: Git is not installed."
  echo "  Ubuntu/Debian: sudo apt install git"
  echo "  macOS: xcode-select --install"
  exit 1
fi

# === DOWNLOAD ===
echo "Downloading configuration..."
if [ -d "$WORK_DIR" ]; then
  cd "$WORK_DIR"
  CURRENT_REMOTE=$(git remote get-url origin 2>/dev/null || echo "")
  if [ "$CURRENT_REMOTE" != "$REPO_URL" ]; then
    git remote set-url origin "$REPO_URL"
  fi
  git pull --quiet
else
  git clone --quiet "$REPO_URL" "$WORK_DIR"
fi

# === BACKUP ===
if [ -f "$CLAUDE_DIR/settings.json" ]; then
  BACKUP="$CLAUDE_DIR/settings.json.bak.$(date +%s)"
  cp "$CLAUDE_DIR/settings.json" "$BACKUP"
  echo "Backed up existing settings.json to $BACKUP"
fi

# === SAFETY CHECK ===
# The installer only writes to rules/, agents/, commands/, skills/, hooks/.
# It does NOT touch: sessions/, projects/, memory/, plans/, mcp-configs/, .agents/
if [ -d "$CLAUDE_DIR/rules/common" ]; then
  echo "NOTE: Existing rules/agents/commands with the same names will be overwritten."
  echo "  Your sessions, projects, memory, and MCP configs are safe."
fi

# === CORE INSTALL ===
echo "Installing core configuration..."
mkdir -p "$CLAUDE_DIR/rules" "$CLAUDE_DIR/agents" "$CLAUDE_DIR/commands" "$CLAUDE_DIR/templates"

# Rules (common + python + typescript + web)
cp -r "$WORK_DIR/rules/common"     "$CLAUDE_DIR/rules/"
cp -r "$WORK_DIR/rules/python"     "$CLAUDE_DIR/rules/"
cp -r "$WORK_DIR/rules/typescript" "$CLAUDE_DIR/rules/"
cp -r "$WORK_DIR/rules/web"        "$CLAUDE_DIR/rules/"

# Solidity rules (optional, or auto-included with --full or defi project)
if [ "$WITH_SOLIDITY" = true ] || [ "$FULL" = true ] || [ "$PROJECT_TYPE" = "defi" ]; then
  cp -r "$WORK_DIR/rules/solidity" "$CLAUDE_DIR/rules/"
  echo "  + Solidity rules"
fi

# Agents
cp "$WORK_DIR/agents/"*.md "$CLAUDE_DIR/agents/"

# Commands
cp "$WORK_DIR/commands/"*.md "$CLAUDE_DIR/commands/"

# Templates (so /init and onboarding can find them in any project)
cp "$WORK_DIR/templates/"*.md "$CLAUDE_DIR/templates/"

# === MERGE PERMISSIONS ===
echo "Setting up default permissions..."
PERMS_FILE="$WORK_DIR/settings/permissions.json"
SETTINGS_FILE="$CLAUDE_DIR/settings.json"

if [ -f "$SETTINGS_FILE" ]; then
  # Try python3 for JSON merge (available on most systems)
  if command -v python3 >/dev/null 2>&1; then
    python3 -c "
import json, sys
with open('$SETTINGS_FILE') as f: settings = json.load(f)
with open('$PERMS_FILE') as f: perms = json.load(f)
if 'permissions' not in settings:
    settings['permissions'] = {}
if 'allow' not in settings['permissions']:
    settings['permissions']['allow'] = []
existing = set(settings['permissions']['allow'])
for p in perms['permissions']['allow']:
    if p not in existing:
        settings['permissions']['allow'].append(p)
with open('$SETTINGS_FILE', 'w') as f: json.dump(settings, f, indent=2)
print('  Merged permissions into existing settings.json')
" 2>/dev/null || echo "  NOTE: Could not auto-merge permissions. Copy them manually from settings/permissions.json"
  elif command -v jq >/dev/null 2>&1; then
    MERGED=$(jq -s '.[0] * {permissions: {allow: (.[0].permissions.allow // [] + .[1].permissions.allow | unique)}}' \
      "$SETTINGS_FILE" "$PERMS_FILE" 2>/dev/null)
    if [ -n "$MERGED" ]; then
      echo "$MERGED" > "$SETTINGS_FILE"
      echo "  Merged permissions into existing settings.json"
    fi
  else
    echo "  NOTE: Neither python3 nor jq found. Copy permissions manually from settings/permissions.json"
  fi
else
  cp "$PERMS_FILE" "$SETTINGS_FILE"
  echo "  Created settings.json with default permissions"
fi

# === SKILLS (--full only) ===
if [ "$FULL" = true ]; then
  echo "Installing skills..."
  mkdir -p "$CLAUDE_DIR/skills"
  cp -r "$WORK_DIR/skills/"* "$CLAUDE_DIR/skills/"
fi

# === HOOKS (--with-hooks or --full) ===
if [ "$WITH_HOOKS" = true ]; then
  echo "Installing hooks..."
  mkdir -p "$CLAUDE_DIR/hooks"
  cp "$WORK_DIR/hooks/"*.sh "$CLAUDE_DIR/hooks/"
  chmod +x "$CLAUDE_DIR/hooks/"*.sh

  # Add hook config to settings.json if python3 available
  if command -v python3 >/dev/null 2>&1; then
    python3 -c "
import json
with open('$SETTINGS_FILE') as f: settings = json.load(f)
if 'hooks' not in settings:
    settings['hooks'] = {}
settings['hooks']['PostToolUse'] = [
    {'matcher': 'Write|Edit', 'command': 'bash ~/.claude/hooks/post-edit-file-size-warn.sh', 'description': 'Warn about large files'},
    {'matcher': 'Write|Edit', 'command': 'bash ~/.claude/hooks/post-edit-console-warn.sh', 'description': 'Warn about debug logging'}
]
settings['hooks']['PreToolUse'] = [
    {'matcher': 'Bash', 'command': 'bash ~/.claude/hooks/pre-commit-secrets-check.sh', 'description': 'Block commits with secrets'}
]
with open('$SETTINGS_FILE', 'w') as f: json.dump(settings, f, indent=2)
print('  Hooks configured in settings.json')
" 2>/dev/null || echo "  NOTE: Could not auto-configure hooks. See hooks/README.md for manual setup."
  else
    echo "  Hook scripts installed. See hooks/README.md for settings.json configuration."
  fi
fi

# === MCP (--full only) ===
if [ "$FULL" = true ]; then
  echo "Installing MCP (Context7)..."
  if command -v claude >/dev/null 2>&1; then
    claude mcp add context7 -- npx -y @upstash/context7-mcp@latest 2>/dev/null || true
    echo "  Context7 MCP added. See mcp/README.md for GitHub and Playwright setup."
  fi
fi

# === PROJECT TEMPLATE ===
if [ -n "$PROJECT_TYPE" ]; then
  TEMPLATE_MAP_real_estate="CLAUDE-real-estate.md"
  TEMPLATE_MAP_song_gift="CLAUDE-song-gift.md"
  TEMPLATE_MAP_eshop="CLAUDE-eshop.md"
  TEMPLATE_MAP_defi="CLAUDE-defi.md"

  # Normalize hyphens to underscores for variable lookup
  NORMALIZED=$(echo "$PROJECT_TYPE" | tr '-' '_')
  TEMPLATE_VAR="TEMPLATE_MAP_${NORMALIZED}"
  TEMPLATE_FILE="${!TEMPLATE_VAR}"

  if [ -z "$TEMPLATE_FILE" ]; then
    echo "Unknown project type: $PROJECT_TYPE"
    echo "Available: real-estate, song-gift, eshop, defi"
  elif [ -f "CLAUDE.md" ]; then
    echo "CLAUDE.md already exists in current directory. Skipping template."
    echo "  Template available at: $WORK_DIR/templates/$TEMPLATE_FILE"
  else
    cp "$WORK_DIR/templates/$TEMPLATE_FILE" "./CLAUDE.md"
    echo "  Created CLAUDE.md from $PROJECT_TYPE template"
  fi
else
  # No --project flag: copy base template if no CLAUDE.md exists
  if [ ! -f "CLAUDE.md" ]; then
    cp "$WORK_DIR/templates/CLAUDE.md" "./CLAUDE.md"
    echo "  Created CLAUDE.md from base template (beginner mode by default)"
    echo "  Use /switch-tier in Claude Code to change your skill level"
  else
    echo "  CLAUDE.md already exists. Skipping base template."
  fi
fi

# === SUMMARY ===
echo ""
echo "Done."
echo ""
echo "  Rules:     $(find "$CLAUDE_DIR/rules" -name '*.md' 2>/dev/null | wc -l) files"
echo "  Agents:    $(ls "$CLAUDE_DIR/agents/"*.md 2>/dev/null | wc -l) files"
echo "  Commands:  $(ls "$CLAUDE_DIR/commands/"*.md 2>/dev/null | wc -l) files"
echo "  Templates: $(ls "$CLAUDE_DIR/templates/"*.md 2>/dev/null | wc -l) files"
if [ "$FULL" = true ]; then
  echo "  Skills:   $(find "$CLAUDE_DIR/skills" -name 'SKILL.md' 2>/dev/null | wc -l) files"
fi
if [ "$WITH_HOOKS" = true ]; then
  echo "  Hooks:    $(ls "$CLAUDE_DIR/hooks/"*.sh 2>/dev/null | wc -l) scripts"
fi
echo ""
echo "Restart Claude Code to apply changes."
echo ""
echo "Quick start:"
echo "  /plan \"what you want to build\"    # Plan before coding"
echo "  /tdd                               # Test-driven development"
echo "  /code-review                       # Review your code"
echo "  /verify                            # Run all checks"
echo "  /switch-tier beginner              # Switch skill level"
