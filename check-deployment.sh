#!/bin/bash

# Mintlify Deployment Verification Script
# Run this to check deployment status

echo "🔍 Checking Mintlify Deployment Status..."
echo ""

# Check GitHub repository
echo "📦 GitHub Repository Status:"
cd ~/mintlify-docs
echo "Current branch: $(git branch --show-current)"
echo "Latest commit: $(git log -1 --oneline)"
echo "Remote: $(git remote get-url origin)"
echo ""

# Check for common Mintlify URLs
echo "🌐 Testing Possible Mintlify URLs:"
echo ""

URLS=(
  "https://thinkbedo.mintlify.app"
  "https://docs-thinkbedo.mintlify.app"
  "https://thinkbedo-docs.mintlify.app"
)

for url in "${URLS[@]}"; do
  echo -n "Testing $url... "
  if curl -s -o /dev/null -w "%{http_code}" "$url" | grep -q "200"; then
    echo "✅ LIVE!"
    echo "🎉 Your documentation is at: $url"
  else
    echo "❌ Not found"
  fi
done

echo ""
echo "📝 Next Steps:"
echo "1. Log into https://dashboard.mintlify.com to get exact URL"
echo "2. Find your MCP server URL in Products > MCP Server"
echo "3. Connect to Claude.ai Settings > Connectors"
echo ""
echo "📚 See DEPLOYMENT_COMPLETE.md for full instructions"
