# Mintlify Setup Complete ✅

**Date**: January 18, 2026
**Documentation Repository**: `/Users/tylerlafleur/mintlify-docs`
**GitHub**: `thinkbedo/docs` (main branch)

---

## ✅ What's Been Set Up

### 1. Prerequisites Installed
- ✅ Node.js v20.19.6 (LTS) - via Homebrew
- ✅ npm v10.8.2
- ✅ Mintlify CLI v4.2.284
- ✅ PATH configured in `.zshrc` for both Node@20 and npm global packages

### 2. Repository Cloned
- ✅ Cloned `https://github.com/thinkbedo/docs` to `~/mintlify-docs`
- ✅ Contains complete starter template with:
  - `docs.json` - Main configuration
  - API reference docs with OpenAPI
  - Guide pages (Getting Started, Customization, Writing Content, AI Tools)
  - Pre-configured navigation and theme

### 3. Local Development Server
- ✅ Running at **http://localhost:3000**
- ✅ Live preview with hot-reload
- ✅ Network access at http://172.20.10.3:3000

---

## 🚀 Quick Commands

```bash
# Start the development server
cd ~/mintlify-docs
mint dev

# Stop the server
# Press Ctrl+C in the terminal

# Validate documentation
mint validate

# Check for broken links
mint broken-links

# Check for accessibility issues
mint a11y

# Update CLI
mint update
```

---

## 📁 Project Structure

```
mintilify-docs/
├── docs.json                 # Main configuration file
├── index.mdx                 # Homepage
├── quickstart.mdx            # Quickstart guide
├── development.mdx           # Development guide
├── essentials/               # Content guides
│   ├── markdown.mdx
│   ├── code.mdx
│   ├── images.mdx
│   ├── navigation.mdx
│   ├── reusable-snippets.mdx
│   └── settings.mdx
├── ai-tools/                 # AI integration docs
│   ├── cursor.mdx
│   ├── claude-code.mdx
│   └── windsurf.mdx
├── api-reference/            # API documentation
│   ├── introduction.mdx
│   ├── openapi.json         # OpenAPI specification
│   └── endpoint/            # API endpoints
└── logo/                     # Brand assets
    ├── light.svg
    └── dark.svg
```

---

## 🔗 Auto-Generated MCP Server

Mintlify automatically generates an MCP server for your documentation:

**MCP Server URL**: `https://docs.thinkbedo.com/mcp` (after deployment)

### Connecting to AI Tools

**Claude.ai**:
1. Go to Settings > Connectors
2. Add custom connector
3. Name: "ThinkBedo Docs"
4. URL: Your MCP server URL
5. Select connector when using Claude

**Cursor/VS Code**:
Add to `.vscode/mcp.json` or Cursor's MCP settings:
```json
{
  "mcpServers": {
    "thinkbedo-docs": {
      "command": "npx",
      "args": ["-y", "@mintlify/mcp"],
      "env": {
        "MINTLIFY_API_URL": "your-mcp-url"
      }
    }
  }
}
```

**Claude Code**:
```bash
claude mcp add --transport http <your-mcp-url>
```

---

## 🔄 Next Steps: Auto-Update from Code Repos

### Goal
When Windsurf Cascade, Claude Code, or Codex commits code to your repositories, automatically update your Mintlify documentation.

### Recommended Approach: GitHub Actions Workflow

#### 1. Install GitHub App
1. Go to [Mintlify Dashboard](https://dashboard.mintlify.com/settings/deployment/git-settings)
2. Install the GitHub App for auto-deployment
3. Link your `thinkbedo/docs` repository

#### 2. Create Documentation Update Workflow

In your **main code repositories**, add `.github/workflows/update-docs.yml`:

```yaml
name: Update Documentation

on:
  push:
    branches: [main, master]
    paths:
      - 'src/**'
      - 'README.md'
      - 'CHANGELOG.md'
      - 'docs/**'

jobs:
  update-docs:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code repo
        uses: actions/checkout@v3
        with:
          fetch-depth: 0  # Get full history for changelog

      - name: Checkout docs repo
        uses: actions/checkout@v3
        with:
          repository: thinkbedo/docs
          token: ${{ secrets.DOCS_REPO_TOKEN }}
          path: docs-repo

      - name: Extract changes from commit
        id: extract
        run: |
          # Get commit message and changed files
          COMMIT_MSG=$(git log -1 --pretty=%B)
          CHANGED_FILES=$(git diff-tree --no-commit-id --name-only -r HEAD)
          
          echo "commit_msg<<EOF" >> $GITHUB_OUTPUT
          echo "$COMMIT_MSG" >> $GITHUB_OUTPUT
          echo "EOF" >> $GITHUB_OUTPUT
          
          echo "changed_files<<EOF" >> $GITHUB_OUTPUT
          echo "$CHANGED_FILES" >> $GITHUB_OUTPUT
          echo "EOF" >> $GITHUB_OUTPUT

      - name: Update changelog in docs
        run: |
          cd docs-repo
          DATE=$(date +"%Y-%m-%d")
          echo "## $DATE - ${GITHUB_REPOSITORY##*/}" >> CHANGELOG.md
          echo "" >> CHANGELOG.md
          echo "${{ steps.extract.outputs.commit_msg }}" >> CHANGELOG.md
          echo "" >> CHANGELOG.md
          echo "### Changed Files:" >> CHANGELOG.md
          echo "\`\`\`" >> CHANGELOG.md
          echo "${{ steps.extract.outputs.changed_files }}" >> CHANGELOG.md
          echo "\`\`\`" >> CHANGELOG.md
          echo "" >> CHANGELOG.md

      - name: Commit and push to docs repo
        run: |
          cd docs-repo
          git config user.name "GitHub Actions"
          git config user.email "actions@github.com"
          git add .
          git commit -m "Auto-update from ${GITHUB_REPOSITORY}: ${GITHUB_SHA:0:7}"
          git push
```

#### 3. Set Up Repository Secret
In your **code repositories**:
1. Go to Settings > Secrets and variables > Actions
2. Create a new secret: `DOCS_REPO_TOKEN`
3. Value: Personal Access Token with `repo` scope for accessing `thinkbedo/docs`

#### 4. Alternative: Direct API Approach

Use Mintlify's API to update docs programmatically:

```javascript
// In your CI/CD or git hooks
const response = await fetch('https://api.mintlify.com/v1/docs/update', {
  method: 'POST',
  headers: {
    'Authorization': `Bearer ${process.env.MINTLIFY_API_KEY}`,
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    project_id: '696d0a1e923b41a287c04f6c',
    updates: {
      changelog: newChanges,
      files: modifiedFiles
    }
  })
});
```

---

## 🎨 Customizing Your Documentation

### Update Brand Colors
Edit `docs.json`:
```json
{
  "colors": {
    "primary": "#YOUR_COLOR",
    "light": "#YOUR_LIGHT_COLOR", 
    "dark": "#YOUR_DARK_COLOR"
  }
}
```

### Update Site Name
Edit `docs.json`:
```json
{
  "name": "ThinkBedo Documentation"
}
```

### Add New Pages
1. Create `.mdx` file in appropriate directory
2. Add to navigation in `docs.json`:
```json
{
  "navigation": {
    "tabs": [{
      "tab": "Guides",
      "groups": [{
        "group": "Your Group",
        "pages": ["path/to/your-page"]
      }]
    }]
  }
}
```

---

## 📚 Resources

- **Mintlify Documentation**: https://mintlify.com/docs
- **Your Dashboard**: https://dashboard.mintlify.com
- **MCP Documentation**: https://modelcontextprotocol.io
- **GitHub Integration**: https://mintlify.com/docs/deploy/github

---

## 🔐 Your Credentials

**Project ID**: `696d0a1e923b41a287c04f6c`
**Admin API Key**: `mint_DMqLWbbfE74rhdfKghrETD`

⚠️ **Security Note**: Keep these credentials secure. Add them to your environment variables or secrets manager.

---

## 💡 Tips

1. **Write in MDX**: Supports React components, custom styling, and interactive elements
2. **Use Snippets**: Create reusable content blocks in `/snippets`
3. **Test Locally**: Always preview changes with `mint dev` before pushing
4. **Enable MCP**: Once deployed, your docs become queryable by AI agents
5. **Monitor Analytics**: Use Mintlify dashboard to track documentation usage

---

## 🆘 Troubleshooting

**Server won't start**:
```bash
# Check Node version (must be v20)
node --version

# If wrong version, use Node@20
export PATH="/opt/homebrew/opt/node@20/bin:$PATH"
```

**Changes not appearing**:
- Hard refresh browser (Cmd+Shift+R)
- Restart dev server
- Check file is in `docs.json` navigation

**Build errors**:
```bash
mint validate  # Check for errors
mint broken-links  # Find broken links
```

---

**Setup completed successfully! 🎉**

Your local server is running at: **http://localhost:3000**
