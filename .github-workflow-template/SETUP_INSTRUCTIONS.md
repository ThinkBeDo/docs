# GitHub Actions Setup for Auto-Updating Documentation

This guide walks you through setting up automatic documentation updates when code is committed to your repositories.

## Overview

When you commit code to any of your repositories (using Windsurf Cascade, Claude Code, Codex, or manually), the GitHub Actions workflow will:
1. Extract commit details (message, author, changed files)
2. Create/update a changelog entry in your Mintlify docs
3. Push the update to the `thinkbedo/docs` repository
4. Trigger automatic deployment on Mintlify

## Prerequisites

- GitHub account with access to your code repositories
- The `thinkbedo/docs` repository (already set up)
- Personal Access Token with `repo` scope

## Step 1: Create GitHub Personal Access Token

1. Go to GitHub Settings: https://github.com/settings/tokens
2. Click "Generate new token" → "Tokens (classic)"
3. Give it a descriptive name: "ThinkBedo Docs Auto-Update"
4. Select scopes:
   - ✅ `repo` (Full control of private repositories)
5. Set expiration (recommend 1 year, then renew)
6. Click "Generate token"
7. **IMPORTANT**: Copy the token immediately - you won't see it again!

## Step 2: Add Secret to Each Code Repository

For **EACH repository** you want to auto-update docs from:

1. Go to the repository on GitHub
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Name: `DOCS_REPO_TOKEN`
5. Value: Paste the Personal Access Token from Step 1
6. Click **Add secret**

## Step 3: Add Workflow File to Code Repository

In your code repository, create the file:
`.github/workflows/update-docs.yml`

Copy the contents from:
`/Users/tylerlafleur/mintlify-docs/.github-workflow-template/update-docs.yml`

### Quick Terminal Command:

```bash
# From your code repository root
mkdir -p .github/workflows
cp /Users/tylerlafleur/mintlify-docs/.github-workflow-template/update-docs.yml .github/workflows/
git add .github/workflows/update-docs.yml
git commit -m "Add documentation auto-update workflow"
git push
```

## Step 4: Test the Workflow

1. Make a commit to your code repository
2. Push to `main` or `master` branch
3. Go to **Actions** tab on GitHub
4. You should see "Update ThinkBedo Documentation" workflow running
5. Check `thinkbedo/docs` repository for the new changelog entry

## How It Works

### Trigger Conditions
The workflow triggers when you push to `main` or `master` and files matching these patterns change:
- `src/**` - Source code changes
- `**.md` - Markdown documentation
- `CHANGELOG.md` - Changelog updates
- `docs/**` - Documentation folder

### What Gets Created
A changelog entry in `thinkbedo/docs/changelogs/YYYY-MM.mdx`:

```markdown
## January 18, 2026 - [your-repo-name]

**Commit**: `abc1234` by Tyler LaFleur

**Changes**:
Your commit message here

**Modified Files**:
```
src/components/Header.tsx
src/utils/api.ts
README.md
```
```

### Changelog Organization
- Monthly files: `changelogs/2026-01.mdx`, `changelogs/2026-02.mdx`, etc.
- Automatically created if they don't exist
- Entries appended chronologically

## Customization Options

### Change Trigger Paths
Edit the `paths` section in `update-docs.yml`:

```yaml
paths:
  - 'src/**'           # Your source code
  - 'lib/**'           # Add other directories
  - '**.ts'            # Specific file types
  - '!tests/**'        # Exclude patterns (! prefix)
```

### Change Branch Names
Edit the `branches` section:

```yaml
branches: [main, master, develop]  # Add more branches
```

### Customize Changelog Format
Edit the `Update changelog documentation` step to change the format.

## Adding to Navigation

To make changelogs visible in your docs:

1. Edit `/Users/tylerlafleur/mintlify-docs/docs.json`
2. Add to navigation:

```json
{
  "group": "Updates",
  "pages": [
    "changelogs/2026-01",
    "changelogs/2025-12"
  ]
}
```

## Repositories to Set Up

Recommended repositories for auto-documentation:

1. **Main product repository** - Your primary codebase
2. **API repositories** - Backend services
3. **Component libraries** - Shared UI components
4. **Internal tools** - Development utilities
5. **Infrastructure repos** - DevOps configurations

## Troubleshooting

### Workflow Not Triggering
- Check that files in `paths` were actually modified
- Verify you pushed to the correct branch
- Check repository has Actions enabled (Settings → Actions)

### Permission Errors
- Verify `DOCS_REPO_TOKEN` is set correctly
- Check token hasn't expired
- Ensure token has `repo` scope

### Changelog Not Appearing
- Check the `thinkbedo/docs` repository for commits
- Verify the file was created in `changelogs/` directory
- Check for git conflicts in the docs repo

### Workflow Failed
- Click on the failed workflow in GitHub Actions
- Expand the step that failed to see error details
- Common issues:
  - Invalid token
  - Git conflicts
  - Syntax errors in changelog formatting

## Alternative: Local Git Hooks

If you prefer local automation instead of GitHub Actions, see:
`/Users/tylerlafleur/mintlify-docs/Auto-Update_Documentation_Workflow`

## Security Best Practices

1. **Never commit tokens** to your repository
2. **Use repository secrets** for sensitive data
3. **Set token expiration** and renew annually
4. **Limit token scope** to only what's needed
5. **Rotate tokens** if compromised

## Next Steps

1. ✅ Set up GitHub Actions workflow
2. ⏭️ Deploy documentation to production
3. ⏭️ Test MCP integration with AI tools
4. ⏭️ Customize documentation content
5. ⏭️ Add project-specific pages

## Support

- Mintlify Documentation: https://mintlify.com/docs
- GitHub Actions Docs: https://docs.github.com/en/actions
- ThinkBedo Dashboard: https://dashboard.thinkbedo.com
