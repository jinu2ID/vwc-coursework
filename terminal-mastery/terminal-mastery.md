# Terminal Mastery Reference

## scaffold.sh

### Shebang

```bash
#!/usr/bin/env bash
```

Tells your shell which interpreter to use. Always the first line of a bash script.

---

### Fail fast

```bash
set -euo pipefail
```

Makes the script fail immediately if anything goes wrong.

- `-e` — exit on error
- `-u` — treat unset variables as errors
- `-o pipefail` — catch errors inside pipes too

---

### Usage check

```bash
if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <project-name>"
  exit 1
fi
```

- `$#` — number of arguments passed
- `$0` — the script's own name
- `-lt 1` — less than 1 argument

---

### Store the argument

```bash
PROJECT_NAME="$1"
```

- `$1` — the first argument passed to the script
- Wrapping in quotes handles names with spaces

---

### Create and enter the folder

```bash
mkdir "$PROJECT_NAME"
cd "$PROJECT_NAME"
```

- `mkdir` — creates the directory
- `cd` — moves into it so all following commands run inside the new project

---

### Initialize git

```bash
git init
git branch -M main
```

- `git init` — creates a new git repo in the current folder
- `git branch -M main` — renames the default branch from `master` to `main`

---

### Create a README

```bash
cat > README.md <<EOF
# $PROJECT_NAME

TODO: describe your project here.
EOF
```

- `cat > README.md` — creates (or overwrites) README.md
- `<<EOF ... EOF` — a "heredoc", lets you write multi-line text inline
- `$PROJECT_NAME` — gets substituted with the actual project name

---

### Create a .gitignore

```bash
cat > .gitignore <<EOF
.env
*.log
.DS_Store
EOF
```

- `.env` — keeps secrets out of git
- `*.log` — ignores all log files
- `.DS_Store` — macOS folder metadata you never want committed

---

### Initial commit

```bash
git add .
git commit -m "Initial commit"
```

- `git add .` — stages all the files you just created
- `git commit -m` — commits them with a message

---

### Confirmation message

```bash
echo "Project '$PROJECT_NAME' created at $(pwd)"
```

- `$(pwd)` — runs the `pwd` command inline and prints the current directory path

---

### Make the script executable

```bash
chmod +x scaffold.sh
```
