# 📁 Multi-Client Projects Structure Guide

## How Toggle Folders Work in Mintlify

### **Visual Example:**

```
Projects Tab (click to switch to this tab)
│
├── 📂 ScalePilot [COLLAPSED ▶]
│
├── 📂 Client Name 1 [COLLAPSED ▶]
│
├── 📂 Client Name 2 [COLLAPSED ▶]
│
└── 📂 Internal Tools [COLLAPSED ▶]
```

**When you click on "ScalePilot ▶":**

```
Projects Tab
│
├── 📂 ScalePilot [EXPANDED ▼]
│   ├── 📄 Overview
│   ├── 📄 Architecture
│   ├── 📄 Changelog
│   ├── 📄 Known Issues
│   └── 📄 Development Notes
│
├── 📂 Client Name 1 [COLLAPSED ▶]
│
├── 📂 Client Name 2 [COLLAPSED ▶]
│
└── 📂 Internal Tools [COLLAPSED ▶]
```

---

## **Key Features:**

✅ **Collapsible Groups**: Each client project is a collapsible group
✅ **Clean Sidebar**: Only expanded sections show their pages
✅ **Unlimited Projects**: Add as many client projects as you need
✅ **Organized**: Easy to navigate without clutter
✅ **Automatic**: Mintlify handles the toggle behavior automatically

---

## **Recommended Project Structure:**

### **Option 1: By Client Name**
```
Projects Tab
├── 📂 Acme Corporation
│   ├── Overview
│   ├── Architecture
│   └── Deployment
│
├── 📂 TechStart Inc
│   ├── Overview
│   ├── API Integration
│   └── Maintenance
│
└── 📂 Global Retail Co
    ├── Overview
    └── E-commerce Platform
```

### **Option 2: By Project Type**
```
Projects Tab
├── 📂 Web Applications
│   ├── Client A - E-commerce
│   ├── Client B - SaaS Platform
│   └── Client C - Marketing Site
│
├── 📂 Mobile Applications
│   ├── Client D - iOS App
│   └── Client E - Android App
│
└── 📂 Internal Tools
    ├── Dashboard
    └── Automation Scripts
```

### **Option 3: Mixed (Recommended for ThinkBeDo)**
```
Projects Tab
├── 📂 ScalePilot (Your SaaS Product)
│   ├── Overview
│   ├── Architecture
│   ├── Changelog
│   ├── Known Issues
│   └── Development Notes
│
├── 📂 Client: Acme Corp
│   ├── Project Overview
│   ├── Technical Specs
│   └── Deployment Guide
│
├── 📂 Client: TechStart
│   ├── Overview
│   └── Integration Docs
│
└── 📂 Internal Resources
    ├── Code Standards
    ├── Deployment Processes
    └── Team Workflows
```

---

## **File System Structure:**

Your actual folder structure should mirror the navigation:

```
mintlify-docs/
└── projects/
    ├── scalepilot/
    │   ├── overview.mdx
    │   ├── architecture.mdx
    │   ├── changelog.mdx
    │   ├── known-issues.mdx
    │   └── development-notes.mdx
    │
    ├── client-acme/
    │   ├── overview.mdx
    │   ├── architecture.mdx
    │   └── deployment.mdx
    │
    ├── client-techstart/
    │   ├── overview.mdx
    │   └── integration.mdx
    │
    └── internal/
        ├── code-standards.mdx
        └── deployment-process.mdx
```

---

## **docs.json Configuration:**

```json
{
  "navigation": {
    "tabs": [
      {
        "tab": "Projects",
        "groups": [
          {
            "group": "ScalePilot",
            "pages": [
              "projects/scalepilot/overview",
              "projects/scalepilot/architecture"
            ]
          },
          {
            "group": "Client: Acme Corp",
            "pages": [
              "projects/client-acme/overview",
              "projects/client-acme/deployment"
            ]
          },
          {
            "group": "Client: TechStart",
            "pages": [
              "projects/client-techstart/overview"
            ]
          }
        ]
      }
    ]
  }
}
```

---

## **Adding a New Client Project:**

### Step 1: Create Folder & Files
```bash
cd ~/mintlify-docs/projects
mkdir client-newclient
cd client-newclient

# Create pages
touch overview.mdx
touch technical-specs.mdx
touch deployment.mdx
```

### Step 2: Add to docs.json
```json
{
  "group": "Client: New Client Name",
  "pages": [
    "projects/client-newclient/overview",
    "projects/client-newclient/technical-specs",
    "projects/client-newclient/deployment"
  ]
}
```

### Step 3: Create Content
```markdown
---
title: "New Client - Overview"
description: "Project overview for New Client"
---

# New Client Project

## Project Details
...
```

### Step 4: Deploy
```bash
git add -A
git commit -m "feat: add New Client project documentation"
git push origin main
```

**Result**: New collapsible group appears in Projects tab!

---

## **Privacy Considerations:**

### **Option A: Single Docs Site (Current)**
- All projects visible to anyone with the link
- Good for: Internal team use, public projects
- URL: https://hp3.mintlify.app/

### **Option B: Separate Docs Sites (Advanced)**
- Each client gets their own Mintlify site
- Complete separation and privacy
- Requires multiple repositories/projects

### **Option C: Authentication (Enterprise)**
- Add password protection to specific sections
- Mintlify supports document-level authentication
- Requires Mintlify Pro/Enterprise plan

### **Recommendation for Now:**
Start with **Option A** (single site, multiple groups):
- Easy to manage
- Searchable across all projects via MCP
- Can always split later if needed
- Control visibility by not sharing specific URLs

---

## **Example Page Templates:**

### Client Overview Template
```markdown
---
title: "Client Name - Overview"
description: "Project overview and key information"
---

# Client Name Project

## Project Summary
Brief description of what you're building for this client.

## Key Technologies
- Technology 1
- Technology 2
- Technology 3

## Timeline
- Start Date: YYYY-MM-DD
- Expected Completion: YYYY-MM-DD

## Team
- Project Lead: Name
- Developers: Names
- Client Contact: Name

## Important Links
- [GitHub Repository](https://github.com/...)
- [Staging Environment](https://staging....)
- [Production](https://production....)
```

### Client Technical Specs Template
```markdown
---
title: "Client Name - Technical Specifications"
---

# Technical Specifications

## Architecture Overview
Describe the system architecture...

## Tech Stack
- Frontend: 
- Backend:
- Database:
- Infrastructure:

## API Endpoints
Document key endpoints...

## Environment Variables
List required environment variables...

## Deployment Process
Step-by-step deployment instructions...
```

---

## **Advanced: Nested Groups (Sub-folders)**

Mintlify also supports nested groups for complex hierarchies:

```json
{
  "tab": "Projects",
  "groups": [
    {
      "group": "ScalePilot",
      "pages": [
        "projects/scalepilot/overview"
      ]
    },
    {
      "group": "Client Projects",
      "pages": [
        {
          "group": "Acme Corp",
          "pages": [
            "projects/acme/overview",
            "projects/acme/deployment"
          ]
        },
        {
          "group": "TechStart",
          "pages": [
            "projects/techstart/overview"
          ]
        }
      ]
    }
  ]
}
```

This creates:
```
Projects Tab
├── 📂 ScalePilot
│
└── 📂 Client Projects
    ├── 📂 Acme Corp
    │   ├── Overview
    │   └── Deployment
    └── 📂 TechStart
        └── Overview
```

---

## **Quick Reference:**

**Add New Client:**
1. Create folder: `projects/client-name/`
2. Create files: `overview.mdx`, etc.
3. Add group to `docs.json` under Projects tab
4. Commit and push to deploy

**Reorganize:**
1. Edit `docs.json` - reorder groups
2. Push changes - structure updates automatically

**Hide Client:**
1. Comment out or remove group from `docs.json`
2. Files remain in repo but won't appear in navigation

---

## **Your Current Setup:**

**Live Now:**
- ✅ Projects tab
- ✅ ScalePilot group (collapsible)
- ✅ 5 pages under ScalePilot

**Ready to Add:**
- ⏳ Additional client project groups
- ⏳ Internal tools/resources group
- ⏳ Templates and standards group

---

## **Next Steps:**

1. **Test Current Structure:**
   - Visit: https://hp3.mintlify.app/
   - Click on Projects tab
   - Click on ScalePilot to expand/collapse
   - Verify toggle behavior works

2. **Plan Your Structure:**
   - List all clients you want to document
   - Decide on naming convention
   - Map out pages for each client

3. **Start Adding Clients:**
   - Use the templates above
   - One client at a time
   - Test after each addition

4. **Refine Over Time:**
   - Adjust structure based on usage
   - Add/remove sections as needed
   - Keep it clean and organized

---

**Questions or need help adding specific clients? Let me know!**
