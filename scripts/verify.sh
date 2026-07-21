#!/bin/sh
set -eu

if command -v lake >/dev/null 2>&1
then
  LAKE=lake
else
  LAKE="${ELAN_HOME:-$HOME/.elan}/bin/lake"
fi

"$LAKE" build

if grep -R -nE '(^|[^[:alnum:]_])(sorry|admit|unsafe)([^[:alnum:]_]|$)|^[[:space:]]*(axiom|constant)([^[:alnum:]_]|$)' \
  --include='*.lean' \
  --exclude-dir='.lake' \
  --exclude-dir='.git' \
  .
then
  echo 'Forbidden Lean declaration or escape found.' >&2
  exit 1
fi

echo 'Lean build and source-integrity checks passed.'
