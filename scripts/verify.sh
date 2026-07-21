#!/bin/sh
set -eu

if command -v lake >/dev/null 2>&1
then
  LAKE=lake
else
  LAKE="${ELAN_HOME:-$HOME/.elan}/bin/lake"
fi

"$LAKE" build

# Aristotle's separate second source is deliberately not part of the primary
# Lake library target. Compile it unchanged in the same pinned Lean/mathlib
# environment as a second verification target.
if [ -f independent/aristotle/Main.lean ]
then
  "$LAKE" env lean independent/aristotle/Main.lean
fi

if grep -R -nE '(^|[^[:alnum:]_])(sorry|admit|unsafe)([^[:alnum:]_]|$)|^[[:space:]]*(axiom|constant)([^[:alnum:]_]|$)' \
  --include='*.lean' \
  --exclude-dir='.lake' \
  --exclude-dir='.git' \
  .
then
  echo 'Forbidden Lean declaration or escape found.' >&2
  exit 1
fi

echo 'Primary and separate-second-source Lean builds and integrity checks passed.'
