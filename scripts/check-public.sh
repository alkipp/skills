#!/bin/sh
# Public-safety check.
#
# This script contains no private names. The list of what must never appear in
# a published skill lives in .check-names, which is gitignored, or in the file
# named by $CHECK_NAMES. Everything else here is generic.
#
# Usage: scripts/check-public.sh [directory]
set -eu

root=${1:-.}
names_file=${CHECK_NAMES:-.check-names}

# Generic classes: private IPs, absolute home/server paths, private keys,
# personal access token shapes.
generic='([0-9]{1,3}\.){3}[0-9]{1,3}|/(srv|home|Users|root|opt)/|BEGIN [A-Z ]*PRIVATE KEY|gh[pousr]_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}'

fail=0

scan() {
  label=$1
  pattern=$2
  hits=$(find "$root" -type f \( -name '*.md' -o -name '*.sh' -o -name '*.yml' -o -name '*.json' \) \
    -not -path '*/.git/*' -not -name 'check-public.sh' -not -name '.check-names*' \
    -exec grep -nEi "$pattern" {} + 2>/dev/null || true)
  if [ -n "$hits" ]; then
    printf '%s\n' "$hits"
    echo "FAIL ($label): the matches above must not be published." >&2
    fail=1
  fi
}

scan "generic" "$generic"

if [ -f "$names_file" ]; then
  names=$(grep -vE '^[[:space:]]*(#|$)' "$names_file" | tr '\n' '|' | sed 's/|$//')
  if [ -n "$names" ]; then
    scan "private names" "$names"
  fi
else
  echo "note: no $names_file, only generic patterns were checked." >&2
fi

[ "$fail" -eq 0 ] && echo "OK: nothing private found."
exit "$fail"
