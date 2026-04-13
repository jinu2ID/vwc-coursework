# Part 1: Environment Setup

1. Create ~/.zshrc from scratch
2. Add aliases: gs, gp, gl, ll,..
3. Configure PATH for you dev tools
4. Add a custom prompt (PROMPT=)
5. source ~/.zshrc and verify

# Part 2: Automation Scripts

Write three scripts. Each one must be executable, documented, and actually useful

- scaffold.sh
  - Spin up a new project folder with git init, README, and .gitignore in one command.
- logscan.sh
  - Grep, sort, and count errors from any log file and print a summary.
- deploy.sh
  - Run tests, build, and push. Fail loudly on any error (set -euo pipefail)

# Part 3: Delegate to Gemini

Install: npm i -g @google/gemini-cli

- Get key: aistudio.google.com → API key
- export GEMINI_API_KEY=...
- Run: gemini
- Give it one scoped task from the list →
  - Write tests for logscan.sh
  - Add --dry-run flag to deploy.sh
  - Generate a man page for scaffold.sh
  - Refactor .zshrc into modular files
  - Add shellcheck to a GitHub Action

# Deliverables

A dotfiles repository on GitHub

- A working ~/.zshrc with aliases and PATH
- Three executable scripts (scaffold, logscan, deploy)
- A README explaining install and usage
- A screenshot of your custom terminal prompt
- A GEMINI.md transcript of your agent session
