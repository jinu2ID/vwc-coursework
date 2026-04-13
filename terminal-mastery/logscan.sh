#!/usr/bin/env bash

set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <logfile> [pattern]"
    exit 1
fi

LOGFILE="$1"
PATTERN="${2:-ERROR}"

if [[ ! -f "$LOGFILE" ]]; then
    echo "Error: file '$LOGFILE' not found."
    exit 1
fi

TOTAL=$(wc -l < "$LOGFILE" | tr -d '[:space:]')
MATCHES=$(grep -c "$PATTERN" "$LOGFILE" || true)
MATCHES=$(echo "$MATCHES" | tr -d '[:space:]')

echo "File    : $LOGFILE"
echo "Pattern : $PATTERN"
echo "Total lines : $TOTAL"
echo "Matches     : $MATCHES"

if [[ "$MATCHES" -eq 0 ]]; then
    echo "No matches found."
else
    grep "$PATTERN" "$LOGFILE" | sort | uniq -c | sort -rn
fi
