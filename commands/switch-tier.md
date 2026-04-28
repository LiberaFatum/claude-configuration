---
description: Switch the skill tier in CLAUDE.md (beginner, intermediate, advanced). Creates CLAUDE.md from template if missing.
---

Switch the skill tier in CLAUDE.md to the level specified by the user: $ARGUMENTS

Valid tiers: `beginner`, `intermediate`, `advanced`.

## Steps

### 1. Resolve the requested tier

If `$ARGUMENTS` is empty or unrecognized, ask the user which tier they want
(beginner, intermediate, advanced) and stop until they answer.

### 2. Ensure CLAUDE.md exists

Check whether `CLAUDE.md` exists in the project root.

**If it does NOT exist:**

1. Read the template at `~/.claude/templates/CLAUDE.md`.
2. Write its contents to `./CLAUDE.md` in the current directory.
3. Tell the user briefly: "Created CLAUDE.md from base template."
4. Continue to step 3.

If the template file is missing, tell the user to run the setup script and stop:
```
bash <(curl -sL https://raw.githubusercontent.com/LiberaFatum/claude-configuration/main/setup.sh)
```

**If CLAUDE.md exists but has no tier markers** (no `<!-- BEGINNER START`,
`<!-- INTERMEDIATE START`, or `<!-- ADVANCED START`), tell the user their CLAUDE.md
does not use the tier system, and offer to replace it with the template
(asking before overwriting). Stop if they decline.

### 3. Switch the tier

Active tiers have self-closing boundary markers:
`<!-- TIERNAME START -->` and `<!-- TIERNAME END -->`

Inactive tiers have wrapping comment markers:
`<!-- TIERNAME START` (no closing `-->`) and `TIERNAME END -->` (no opening `<!--`)

Process:

1. Find the currently active tier (the one with self-closing markers).
2. **Deactivate it:**
   - Change `<!-- TIERNAME START -->` to `<!-- TIERNAME START` (remove ` -->` at end)
   - Change `<!-- TIERNAME END -->` to `TIERNAME END -->` (remove `<!-- ` at start)
3. **Activate the requested tier:**
   - Change `<!-- TIERNAME START` to `<!-- TIERNAME START -->` (add ` -->` at end)
   - Change `TIERNAME END -->` to `<!-- TIERNAME END -->` (add `<!-- ` at start)
4. Save CLAUDE.md.

Only ONE tier should be active at a time.

### 4. Confirm

Tell the user in one short sentence which tier is now active.
If you also created CLAUDE.md in step 2, mention that too.
