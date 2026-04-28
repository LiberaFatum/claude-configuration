# Hooks

Optional bash hooks that catch common mistakes. No Node.js dependency required.

## Available Hooks

| Hook | Trigger | Blocking? | What it does |
|------|---------|-----------|-------------|
| `post-edit-file-size-warn.sh` | After Write/Edit | No | Warns if file exceeds 400 lines |
| `pre-commit-secrets-check.sh` | Before git commit | Yes | Blocks commits with API keys, private keys |
| `post-edit-console-warn.sh` | After Write/Edit | No | Warns about console.log / print() |

## Installation

The `setup.sh --with-hooks` flag installs these automatically. To install manually, add to your `~/.claude/settings.json`:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "command": "bash ~/.claude/hooks/post-edit-file-size-warn.sh",
        "description": "Warn about large files"
      },
      {
        "matcher": "Write|Edit",
        "command": "bash ~/.claude/hooks/post-edit-console-warn.sh",
        "description": "Warn about debug logging"
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Bash",
        "command": "bash ~/.claude/hooks/pre-commit-secrets-check.sh",
        "description": "Block commits with secrets"
      }
    ]
  }
}
```

## How Hooks Work

- **PostToolUse**: Runs after Claude edits or creates a file. Non-blocking warnings.
- **PreToolUse**: Runs before Claude executes a command. Exit code 2 blocks the action.
- Hooks receive tool context via environment variables (`TOOL_INPUT_FILE_PATH`, `TOOL_INPUT_COMMAND`).
