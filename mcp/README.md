# MCP Server Configuration

MCP (Model Context Protocol) servers extend Claude Code with external tool access.

## Included Configs

### context7.json (recommended)
Library documentation lookup. No API key needed. Free.
Enables Claude to look up current docs for npm packages, Python libraries, etc.

### github-template.json (optional)
GitHub integration for PR management and code search.
**Requires:** A GitHub Personal Access Token.
1. Go to https://github.com/settings/tokens
2. Create a token with `repo` scope
3. Replace `YOUR_GITHUB_TOKEN_HERE` in the file

### playwright.json (optional)
Browser automation for E2E testing. No API key needed.

## How to Install

Copy the desired config into your Claude Code settings. You can do this by:

1. Running `claude mcp add-from-claude-desktop` if using Claude Desktop
2. Or manually merging into `~/.claude.json` or your project's `.claude/settings.json`

Example merge for context7:
```bash
# The setup.sh --full flag does this automatically
claude mcp add context7 -- npx -y @upstash/context7-mcp@latest
```

## Notes

- Each MCP server adds startup time and context. Keep only what you use.
- API keys should never be committed — use environment variables when possible.
