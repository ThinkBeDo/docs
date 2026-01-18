# Auto-Update Documentation Workflow

## Quick Setup Guide for Windsurf/Claude Code/Codex Integration

### Step 1: Create GitHub Personal Access Token

1. Go to GitHub Settings > Developer settings > Personal access tokens > Tokens (classic)
2. Generate new token with `repo` scope
3. Save the token securely

### Step 2: Add Secret to Code Repositories

For **each repository** you want to auto-update docs from:

1. Go to repo Settings > Secrets and variables > Actions
2. Create new repository secret:
   - Name: `DOCS_REPO_TOKEN`
   - Value: Your personal access token from Step 1

### Step 3: Add Workflow File

Create `.github/workflows/update-docs.yml` in your code repository:

```yaml
name: Update Documentation

on:
  push:
    branches: [main, master]
    # Trigger only on relevant file changes
    paths:
      - 'src/**'
      - '**.md'
      - 'CHANGELOG.md'
      - 'docs/**'

jobs:
  update-docs:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code repository
        uses: actions/checkout@v3
        with:
          fetch-depth: 2  # Get last 2 commits for diff

      - name: Checkout docs repository
        uses: actions/checkout@v3
        with:
          repository: thinkbedo/docs
          token: ${{ secrets.DOCS_REPO_TOKEN }}
          path: docs-repo
          ref: main

      - name: Extract commit information
        id: commit_info
        run: |
          # Get commit details
          COMMIT_MSG=$(git log -1 --pretty=%B)
          COMMIT_AUTHOR=$(git log -1 --pretty=%an)
          COMMIT_SHA=$(git log -1 --pretty=%H)
          COMMIT_SHORT_SHA=$(git log -1 --pretty=%h)
          REPO_NAME="${GITHUB_REPOSITORY##*/}"
          
          # Get changed files
          CHANGED_FILES=$(git diff-tree --no-commit-id --name-only -r HEAD | head -20)
          
          # Output for next steps
          {
            echo "commit_msg<<EOF"
            echo "$COMMIT_MSG"
            echo "EOF"
            echo "commit_author=$COMMIT_AUTHOR"
            echo "commit_sha=$COMMIT_SHORT_SHA"
            echo "repo_name=$REPO_NAME"
            echo "changed_files<<EOF"
            echo "$CHANGED_FILES"
            echo "EOF"
          } >> "$GITHUB_OUTPUT"

      - name: Update changelog documentation
        env:
          COMMIT_MSG: ${{ steps.commit_info.outputs.commit_msg }}
          COMMIT_AUTHOR: ${{ steps.commit_info.outputs.commit_author }}
          COMMIT_SHA: ${{ steps.commit_info.outputs.commit_sha }}
          REPO_NAME: ${{ steps.commit_info.outputs.repo_name }}
          CHANGED_FILES: ${{ steps.commit_info.outputs.changed_files }}
        run: |
          cd docs-repo
          DATE=$(date +"%B %d, %Y")
          
          # Ensure changelog directory exists
          mkdir -p changelogs
          
          # Create or append to changelog file
          CHANGELOG_FILE="changelogs/$(date +%Y-%m).mdx"
          
          if [ ! -f "$CHANGELOG_FILE" ]; then
            # Create new monthly changelog file
            cat > "$CHANGELOG_FILE" << 'HEADER'
---
title: "Changelog - $(date +"%B %Y")"
description: "Recent updates and changes"
---

HEADER
          fi
          
          # Append new entry
          cat >> "$CHANGELOG_FILE" << EOF
          
## $DATE - [$REPO_NAME]

**Commit**: \`$COMMIT_SHA\` by $COMMIT_AUTHOR

**Changes**:
$COMMIT_MSG

**Modified Files**:
\`\`\`
$CHANGED_FILES
\`\`\`

---

EOF

      - name: Commit and push changes
        run: |
          cd docs-repo
          git config user.name "Documentation Bot"
          git config user.email "bot@thinkbedo.com"
          git add .
          
          if git diff --staged --quiet; then
            echo "No changes to commit"
          else
            git commit -m "📝 Auto-update from ${{ steps.commit_info.outputs.repo_name }}: ${{ steps.commit_info.outputs.commit_sha }}"
            git push origin main
          fi

      - name: Notify completion
        if: success()
        run: |
          echo "✅ Documentation updated successfully!"
          echo "View at: https://github.com/thinkbedo/docs"
```

### Step 4: Test the Workflow

1. Make a commit to your code repository
2. Push to `main` or `master` branch
3. Check Actions tab to see workflow run
4. Verify changes appear in `thinkbedo/docs` repository

---

## Alternative: Post-Commit Git Hook

For local commits (before push), create `.git/hooks/post-commit`:

```bash
#!/bin/bash

# Configuration
DOCS_REPO_PATH="/Users/tylerlafleur/mintlify-docs"
CODE_REPO_NAME=$(basename $(git rev-parse --show-toplevel))

# Get commit information
COMMIT_MSG=$(git log -1 --pretty=%B)
COMMIT_SHA=$(git log -1 --pretty=%h)
COMMIT_AUTHOR=$(git log -1 --pretty=%an)
DATE=$(date +"%B %d, %Y")

# Navigate to docs repo
cd "$DOCS_REPO_PATH" || exit

# Create changelog entry
CHANGELOG_FILE="changelogs/$(date +%Y-%m).mdx"
mkdir -p changelogs

cat >> "$CHANGELOG_FILE" << EOF

## $DATE - [$CODE_REPO_NAME]

**Commit**: \`$COMMIT_SHA\` by $COMMIT_AUTHOR

**Changes**:
$COMMIT_MSG

---

EOF

# Commit to docs repo
git add .
git commit -m "📝 Auto-update from $CODE_REPO_NAME: $COMMIT_SHA"

echo "✅ Documentation changelog updated!"
echo "Remember to push docs repo: cd $DOCS_REPO_PATH && git push"
```

Make executable:
```bash
chmod +x .git/hooks/post-commit
```

---

## Integration with AI Coding Tools

### Windsurf Cascade
Add to `.windsurfrules`:
```
On commit: Update documentation changelog in /Users/tylerlafleur/mintlify-docs/changelogs/
```

### Claude Code
Add to project configuration:
```json
{
  "post_commit_hooks": [
    "update_docs_changelog"
  ]
}
```

### Codex
Add to `.codex/config.json`:
```json
{
  "hooks": {
    "post_commit": "bash .codex/update-docs.sh"
  }
}
```

---

## Best Practices

1. **Meaningful Commit Messages**: AI tools and workflows rely on clear commit messages
2. **Separate Concerns**: Keep documentation updates in separate docs repo
3. **Review Before Push**: Check documentation changes before pushing to production
4. **Use Conventional Commits**: Helps with automatic changelog generation
   - `feat:` - New features
   - `fix:` - Bug fixes
   - `docs:` - Documentation changes
   - `refactor:` - Code refactoring

---

## Monitoring & Maintenance

- Check GitHub Actions regularly for failed workflows
- Review generated changelogs monthly
- Update workflow if repository structure changes
- Keep DOCS_REPO_TOKEN fresh (regenerate annually)

---

**Questions or Issues?**
- Mintlify Support: https://mintlify.com/docs/contact-support
- GitHub Actions Docs: https://docs.github.com/en/actions
