---
description: Switch the skill tier in CLAUDE.md (beginner, intermediate, advanced)
---

Switch the skill tier in CLAUDE.md to the level specified by the user: $ARGUMENTS

Valid tiers: beginner, intermediate, advanced.

Steps:
1. Read CLAUDE.md from the project root.
2. Identify which tier is currently active. Active tiers have self-closing boundary markers:
   `<!-- TIERNAME START -->` and `<!-- TIERNAME END -->`
   Inactive tiers have wrapping comment markers:
   `<!-- TIERNAME START` (no closing `-->`) and `TIERNAME END -->` (no opening `<!--`)
3. Deactivate the currently active tier by editing its markers:
   - Change `<!-- TIERNAME START -->` to `<!-- TIERNAME START` (remove ` -->` at end)
   - Change `<!-- TIERNAME END -->` to `TIERNAME END -->` (remove `<!-- ` at start)
4. Activate the requested tier by editing its markers:
   - Change `<!-- TIERNAME START` to `<!-- TIERNAME START -->` (add ` -->` at end)
   - Change `TIERNAME END -->` to `<!-- TIERNAME END -->` (add `<!-- ` at start)
5. Save CLAUDE.md.
6. Confirm the switch to the user in one sentence.

If no tier is specified or the value is not recognized, ask the user which tier they want:
beginner, intermediate, or advanced.

Only ONE tier should be active at a time.

Edge cases:
- If CLAUDE.md does not exist in the project root, inform the user and suggest
  running the setup script or `/init` to create one.
- If CLAUDE.md exists but has no tier markers (no `<!-- BEGINNER START`,
  `<!-- INTERMEDIATE START`, or `<!-- ADVANCED START`), inform the user that
  their CLAUDE.md does not use the tier system and suggest recreating it
  with `/init`.
