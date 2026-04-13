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

---

## logscan.sh

### Usage check with optional argument

```bash
if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <logfile> [pattern]"
  exit 1
fi
```

`[pattern]` in brackets means it's optional — a default is set in the next step.

---

### Store arguments with a default

```bash
LOGFILE="$1"
PATTERN="${2:-ERROR}"
```

- `$1` — the log file path
- `${2:-ERROR}` — use the second argument if provided, otherwise default to `ERROR`

---

### Check the file exists

```bash
if [[ ! -f "$LOGFILE" ]]; then
  echo "Error: file '$LOGFILE' not found."
  exit 1
fi
```

- `! -f` — "not a file" — true if the file doesn't exist

---

### Count lines and matches

```bash
TOTAL=$(wc -l < "$LOGFILE")
MATCHES=$(grep -c "$PATTERN" "$LOGFILE" || true)
```

- `wc -l` — counts lines in the file
- `$(...)` — runs the command and stores the result in a variable
- `grep -c` — counts the number of matching lines
- `|| true` — prevents the script from exiting if grep finds zero matches (`-e` treats a no-match as an error)

---

### Print a summary

```bash
echo "File    : $LOGFILE"
echo "Pattern : $PATTERN"
echo "Total lines : $TOTAL"
echo "Matches     : $MATCHES"
```

---

### Print matching lines

```bash
if [[ "$MATCHES" -eq 0 ]]; then
  echo "No matches found."
else
  grep "$PATTERN" "$LOGFILE" | sort | uniq -c | sort -rn
fi
```

- `sort` — alphabetically sorts lines so duplicates are adjacent
- `uniq -c` — collapses duplicates and prefixes each with a count
- `sort -rn` — sorts by count, highest first

---

## chmod

```bash
chmod +x script.sh
```

Changes the permissions on a file. `+x` adds the execute permission, making it runnable as a script.

View permissions with `ls -la`:
```
-rw-r--r--  script.sh   ← before (not executable)
-rwxr-xr-x  script.sh   ← after (executable)
```

Permission characters:
- `r` — read
- `w` — write
- `x` — execute

The three groups are: **owner**, **group**, **everyone else**

---

## deploy.sh

### Default branch argument

```bash
BRANCH="${1:-main}"
```

No usage check needed — if no argument is passed it defaults to `main`.

---

### Guard: must be in a git repo

```bash
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  echo "Error: not inside a git repository."
  exit 1
fi
```

- `git rev-parse --git-dir` — checks if you're inside a git repo
- `> /dev/null 2>&1` — silences output (we only care about the exit code)
- `!` — inverts the check, so we enter the if block on failure

Catches the error early before wasting time running tests and build.

---

### Guard: no uncommitted changes

```bash
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "Error: you have uncommitted changes. Commit or stash them first."
  exit 1
fi
```

- `git diff --quiet` — checks for unstaged changes
- `git diff --cached --quiet` — checks for staged but uncommitted changes
- `||` — if either is true, exit

The script assumes you've committed your work beforehand and handles the test → build → push pipeline.

---

### Run tests

```bash
echo "Running tests..."
npm test
```

If tests fail, `set -e` kills the script automatically. Swap `npm test` for your project's test runner (e.g. `pytest`, `go test ./...`).

---

### Build

```bash
echo "Building..."
npm run build
```

Same as tests — if the build fails, `set -e` stops the script.

---

### Push

```bash
echo "Pushing to '$BRANCH'..."
git push origin "$BRANCH"
```

- `origin` — the default name for your remote repository (usually GitHub)
- `"$BRANCH"` — uses the branch variable set at the top

---

### Success message

```bash
echo "Deploy complete!"
```
