---
description: "Initialize autonomous development for any project type"
argument-hint: "[project_spec_file]"
allowed-tools:
  - Read
  - Write
  - Bash
---

# Initialize Autonomous Development

This command sets up autonomous development for any project type by:

1. Analyzing project specifications
2. Detecting project type (Web, Django, Desktop, ML/AI)
3. Creating master development plan
4. Setting up context tracking

## Usage

/init_autonomous [project_spec_file]

If no file specified, looks for:
- project_specs.md
- system_specs.md  
- requirements.md
- README.md

The system will automatically detect project type and create appropriate development plan.

Begin autonomous initialization now.
