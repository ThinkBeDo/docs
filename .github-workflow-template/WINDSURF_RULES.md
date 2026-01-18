# MINTLIFY DOCUMENTATION AUTO-UPDATE PROTOCOL

## When to Update Documentation

After successfully committing and pushing code to ANY monitored repository, automatically update the corresponding project documentation in Mintlify.

## Monitored Repositories

- **scalepilot** → `~/mintlify-docs/projects/scalepilot/`
- Add more projects as needed following the same pattern

## Update Process

### Step 1: Identify Target Project
Based on the repository being committed to, determine the project folder:
- Repository: `scalepilot` → Folder: `projects/scalepilot/`
- Repository: `martini-ghl-sync` → Folder: `projects/martini-ghl-sync/`
- etc.

### Step 2: Update Changelog
Navigate to: `~/mintlify-docs/projects/[project-name]/changelog.mdx`

Append new entry in this format:

```markdown
## [Month Day, Year] - [Commit Description]

**Commit**: `[short-hash]` by [Author Name]

**Changes**:
[Commit message - preserve formatting and details]

**Modified Files**:
\`\`\`
[List of changed files - one per line, limit to top 20 if many files]
\`\`\`

---
```

**Example**:
```markdown
## January 18, 2026 - Fixed authentication bug

**Commit**: `a1b2c3d` by Tyler LaFleur

**Changes**:
Fixed JWT token expiration issue causing premature logouts
- Updated token refresh logic
- Added better error handling
- Improved session persistence

**Modified Files**:
\`\`\`
src/auth/token-manager.ts
src/middleware/auth.ts
tests/auth.test.ts
\`\`\`

---
```

### Step 3: Update Development Notes (When Significant)

If the commit includes:
- **New features** → Add to "Recent Sessions" section
- **Important decisions** → Add to "Key Decisions" section  
- **Bugs fixed** → Update and move from known-issues.mdx to development-notes.mdx "Recent Sessions"
- **New patterns** → Add to "Code Patterns & Conventions"

Navigate to: `~/mintlify-docs/projects/[project-name]/development-notes.mdx`

Add entry under "Recent Sessions":

```markdown
### [Month Day, Year] - [Session Focus]
**Duration**: [If tracking time]  
**Goal**: [What was being worked on]

**What Was Done**:
- [Achievement 1]
- [Achievement 2]

**Key Decisions**:
- [Decision and rationale]

**Blockers Encountered**:
- [Any issues and how resolved]

**Next Steps**:
- [What needs to happen next]

---
```

### Step 4: Update Known Issues (When Applicable)

**When a bug is DISCOVERED**:
Navigate to: `~/mintlify-docs/projects/[project-name]/known-issues.mdx`

Add under "Active Issues":

```markdown
### [Issue Title]
**Status**: Open  
**Priority**: [High/Medium/Low]  
**Discovered**: [Date]  

**Description**:
[What's the problem?]

**Impact**:
[How does this affect the system?]

**Workaround**:
[Any temporary solutions?]

---
```

**When a bug is FIXED**:
- Move from "Active Issues" to "Resolved Issues"
- Update with resolution details:

```markdown
### [Issue Title]
**Status**: Resolved  
**Resolved**: [Date]  
**Commit**: `[hash]`

**Description**:
[What was the problem?]

**Resolution**:
[How was it fixed?]

**Lessons Learned**:
[What did we learn?]

---
```

### Step 5: Commit Documentation Updates

After updating the documentation files:

```bash
cd ~/mintlify-docs
git add .
git commit -m "📝 Auto-update: [project-name] - [brief description]"
git push origin main
```

## Decision Tree: What to Update?

```
COMMIT MADE TO REPOSITORY
    ↓
UPDATE changelog.mdx (ALWAYS)
    ↓
Is this a significant change?
    ├─ YES → UPDATE development-notes.mdx
    │   ├─ New feature? → Add to "Recent Sessions"
    │   ├─ Important decision? → Add to "Key Decisions"
    │   └─ New pattern? → Add to "Code Patterns"
    │
    └─ NO → Skip development-notes.mdx
    ↓
Does this involve bugs?
    ├─ BUG DISCOVERED → ADD to known-issues.mdx "Active Issues"
    ├─ BUG FIXED → MOVE in known-issues.mdx from "Active" to "Resolved"
    └─ NO BUGS → Skip known-issues.mdx
    ↓
COMMIT & PUSH DOCUMENTATION
```

## Examples by Commit Type

### Example 1: Simple Bug Fix
```
Repository: scalepilot
Commit: "Fix typo in user profile component"

Updates:
✅ changelog.mdx - Add entry
❌ development-notes.mdx - Too minor
❌ known-issues.mdx - Not applicable
```

### Example 2: Major Feature Implementation
```
Repository: scalepilot
Commit: "Implement OAuth authentication with Google"

Updates:
✅ changelog.mdx - Add entry
✅ development-notes.mdx - Add to "Recent Sessions" + "Key Decisions"
❌ known-issues.mdx - Not applicable (unless issues discovered)
```

### Example 3: Bug Discovery
```
Repository: scalepilot
Commit: "Add TODO: Race condition in payment processing"

Updates:
✅ changelog.mdx - Add entry
✅ known-issues.mdx - Add to "Active Issues"
❌ development-notes.mdx - Not a solution yet
```

### Example 4: Bug Resolution
```
Repository: scalepilot  
Commit: "Fix: Resolve race condition in payment processing"

Updates:
✅ changelog.mdx - Add entry
✅ development-notes.mdx - Add resolution details to "Recent Sessions"
✅ known-issues.mdx - Move from "Active" to "Resolved"
```

## Special Considerations

### Multiple Files Changed
- List all changed files in changelog
- If more than 20 files, list top 20 and add "[...and X more files]"

### Breaking Changes
- Clearly mark as "⚠️ BREAKING CHANGE" in changelog
- Add detailed migration notes to development-notes.mdx

### Refactoring
- Focus on WHY the refactor was done
- Document pattern changes in development-notes.mdx

### Configuration Changes
- Note any environment variable or config changes
- Update architecture.mdx if infrastructure changes

## Automation Guidelines

**DO:**
- Keep entries concise but informative
- Preserve the original commit message tone
- Use consistent date formatting (Month DD, YYYY)
- Always include commit hash and author

**DON'T:**
- Duplicate information across files
- Add entries for automated commits (like "Update dependencies")
- Editorialize - report facts, not opinions
- Skip the git commit/push step

## File Locations Reference

```
~/mintlify-docs/
└── projects/
    └── [project-name]/
        ├── overview.mdx           # Don't auto-update
        ├── architecture.mdx       # Manual updates only
        ├── changelog.mdx          # ✅ ALWAYS update
        ├── known-issues.mdx       # ✅ Update when bugs involved
        └── development-notes.mdx  # ✅ Update for significant changes
```

## Testing the Updates

After pushing documentation updates:
1. Check GitHub repository: `thinkbedo/docs` for commit
2. Wait ~1-2 minutes for Mintlify auto-deploy
3. Verify changes at: `https://docs.thinkbedo.com/projects/[project-name]/changelog`

---

**Last Updated**: January 18, 2026
**Maintained By**: Tyler LaFleur
**Documentation System**: Mintlify
