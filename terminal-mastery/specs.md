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

