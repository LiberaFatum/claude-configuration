# Beginner's Guide to Claude Code

This guide is for people who are new to programming or new to Claude Code. It will teach you how to work with Claude effectively and not waste money on tokens.

---

## What is Claude Code?

Claude Code is an AI programmer that lives in your terminal. You describe what you want, and it writes the code for you. But like any tool, the quality of what you get depends on how you use it.

This configuration makes Claude:
- Plan before coding (fewer mistakes)
- Write tests before code (catches bugs early)
- Review its own code (catches problems before they land)
- Stop and ask you when it's unsure (no silent wrong turns)

---

## The Three Golden Rules

### 1. Always plan first

Before asking Claude to build anything, type:

```
/plan "what you want to build"
```

Claude will create a step-by-step plan and show it to you. Read it. If it sounds right, say "go ahead." If not, say what's wrong.

**Why this matters:** Without a plan, Claude might build the wrong thing. Fixing a wrong implementation costs 10x more tokens than fixing a wrong plan.

### 2. Review before committing

After Claude finishes writing code, type:

```
/code-review
```

This checks for bugs, security problems, and code quality issues. Think of it as a second pair of eyes.

### 3. Clean context between tasks

When you finish one task and want to start a different one, type:

```
/compact
```

This frees up Claude's memory so it can focus on the new task. Without this, Claude carries old context around, which makes it slower, more expensive, and more confused.

---

## How to Write Good Prompts

Your prompt is the most important factor in getting good results. Here's how to write them:

### Bad prompts (waste tokens, get wrong results)

```
make a website
```

```
fix this
```

```
add authentication
```

These are too vague. Claude has to guess what you want, and it will guess wrong.

### Okay prompts (work but could be better)

```
Create a React component that shows a list of products with prices
```

```
Fix the error in the login function — it returns 500 when the password is wrong
```

```
Add JWT authentication to the FastAPI backend
```

These give Claude enough context to start working.

### Best prompts (save tokens, get right results)

```
Create a React component called ProductList that:
- Takes an array of products (name, price, image_url)
- Shows them in a responsive grid (3 columns on desktop, 1 on mobile)
- Each product card has name, price formatted as CZK, and image
- Clicking a card opens the product detail page at /product/[id]
```

```
Fix the login endpoint in src/api/auth.py:
- When password is wrong, it currently returns 500 with a stack trace
- It should return 401 with {"error": "Invalid credentials"}
- The problem is on line 45 where it calls verify_password() without try/catch
```

```
Add JWT authentication to the FastAPI backend:
- Use python-jose for JWT tokens
- Access token expires in 15 minutes, refresh token in 7 days
- Store refresh tokens in the PostgreSQL users table
- Protected endpoints should use a Depends(get_current_user) dependency
- Follow the existing pattern in src/api/dependencies.py
```

**Pattern:** Tell Claude WHAT you want, WHERE it goes, and HOW it should work. The more specific you are, the fewer attempts Claude needs.

---

## Your First Project Setup

### Step 1: Install this configuration

```bash
bash <(curl -sL https://raw.githubusercontent.com/LiberaFatum/claude-configuration/main/setup.sh)
```

Restart Claude Code after installing.

### Step 2: Start a new project

```bash
mkdir my-project
cd my-project
```

Then in Claude Code:

```
/init eshop
```

This creates a CLAUDE.md file with the right settings for your project type.

### Step 3: Open CLAUDE.md and fill in the basics

The CLAUDE.md file tells Claude about your project. Open it and fill in the `[TODO]` sections. If you're not sure, just describe what the project does in 2-3 sentences — that's enough to start.

### Step 4: Start building

```
/plan "create a product listing page that shows products from the database"
```

Read the plan. If it looks right, say "go ahead."

---

## Understanding Commands

You don't need to memorize all of them. Start with these three:

| Command | When to use it | What it does |
|---------|---------------|-------------|
| `/plan` | Before building anything | Creates a plan for you to review |
| `/code-review` | After Claude writes code | Checks for bugs and problems |
| `/verify` | Before committing code | Runs all tests and checks |

When you're comfortable, add these:

| Command | When to use it | What it does |
|---------|---------------|-------------|
| `/tdd` | When building a new feature | Writes tests first, then code |
| `/build-fix` | When the code won't compile | Fixes build errors |
| `/compact` | Between different tasks | Frees context, saves tokens |
| `/init` | Starting a new project | Creates project config files |

---

## How to Save Money on Tokens

Tokens = the units Claude charges for. More tokens = more expensive. Here's how to minimize waste:

### 1. Be specific (saves 30-50%)

Every time Claude guesses wrong and has to redo, you pay for both attempts. A specific prompt costs the same as a vague one, but gets it right the first time.

### 2. Use /plan (saves 30-60%)

A wrong implementation costs 5000-20000 tokens to fix. A wrong plan costs 500 tokens to fix. Always plan first.

### 3. Use /compact (saves 10-20%)

Old context makes every prompt more expensive. Clean it up between tasks.

### 4. Don't fight bug loops

If Claude tries to fix the same error 3 times and fails, it will stop and tell you. This is intentional — it prevents burning through tokens on a problem that needs human input.

When this happens:
- Read the error message yourself
- Google it if needed
- Tell Claude specifically what you think the problem is

### 5. One task at a time

Don't say "fix the login bug and also add product search and also update the navbar." Each task should be a separate conversation, or at least separated by `/compact`.

### 6. Don't ask Claude to explain everything

If you want to learn, ask. But if you just want the code to work, saying "don't explain, just implement" saves tokens on explanations you might not read.

---

## What the CLAUDE.md File Does

The CLAUDE.md file in your project root is the most important file for Claude Code. It tells Claude:

- What your project is about
- What technologies you use
- What rules to follow
- When to stop and ask you

**Your friends who can't code well should pay special attention to the "Budget Guard" section in CLAUDE.md:**

```markdown
## Budget Guard
- Before starting any task, estimate the number of files to touch.
  If more than 10, confirm with the user.
- If stuck on the same error for 3 iterations, STOP and explain
  what you tried and what the blocker is.
```

This prevents Claude from spinning its wheels on a problem it can't solve — which is the #1 source of wasted tokens for beginners.

**You can add a "User Context" section to tell Claude about your experience level:**

```markdown
## User Context
I am learning to program. When you encounter errors:
- Explain what went wrong in simple terms
- Show me what you changed and why
- If something is too complex, suggest a simpler approach first
```

---

## Common Mistakes to Avoid

### Mistake: Saying "yes" to everything Claude suggests

Sometimes Claude proposes adding extra features, refactoring, or "improving" things you didn't ask for. This costs tokens and introduces bugs.

**Fix:** Say "no, just do what I asked."

### Mistake: Not reading error messages

When something fails, read what Claude says about the error before asking it to "fix it." If you just say "fix it," Claude will guess — and might make it worse.

**Fix:** Read the error, then tell Claude what you think is wrong.

### Mistake: Asking Claude to do too much at once

"Build me an entire e-shop" will produce a mess that's hard to debug. Claude works best on focused, well-defined tasks.

**Fix:** Break it into pieces: "Create the product model," then "Create the product listing page," then "Add the shopping cart."

### Mistake: Not using /compact

After 30+ messages, Claude's context is bloated. Responses get slower, more expensive, and less accurate.

**Fix:** `/compact` after finishing each task. Start fresh.

### Mistake: Fighting Claude on errors it can't fix

If Claude fails 3 times on the same error, there's usually a reason it can't solve it alone (missing dependency, environment issue, wrong assumption about your setup).

**Fix:** Read the error yourself. Search for it online. Give Claude the specific information it's missing.

---

## Quick Reference Card

```
BEFORE CODING:    /plan "what to build"
WHILE CODING:     Let Claude work — it uses /tdd and agents automatically
AFTER CODING:     /code-review
BEFORE COMMIT:    /verify
BETWEEN TASKS:    /compact
NEW PROJECT:      /init <type>
BUILD BROKEN:     /build-fix
```

When in doubt: describe what you want as specifically as possible, and let Claude figure out the implementation.
