# ~/.zshrc - Shell configuration (created from scratch)

# ─── PATH ────────────────────────────────────────────────────────────────────
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# ─── ENV VARS ────────────────────────────────────────────────────────────────
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export EDITOR="code"
export LANG="en_US.UTF-8"

# ─── NVM ─────────────────────────────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ─── PROMPT ──────────────────────────────────────────────────────────────────
# Starship cross-shell prompt
eval "$(starship init zsh)"

# ─── ALIASES ─────────────────────────────────────────────────────────────────
# Git shortcuts
alias gs='git status'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias ga='git add'
alias gc='git commit'
alias gd='git diff'

# Filesystem
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'

# Reload this file
alias reload='source ~/.zshrc'
