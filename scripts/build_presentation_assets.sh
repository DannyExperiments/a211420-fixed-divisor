#!/bin/sh
set -eu

for dependency in latexmk pdflatex pdftoppm
do
  if ! command -v "$dependency" >/dev/null 2>&1
  then
    echo "Missing required dependency: $dependency" >&2
    exit 127
  fi
done

SCRIPT_DIR=$(CDPATH= cd "$(dirname "$0")" && pwd)
REPO_ROOT=$(CDPATH= cd "$SCRIPT_DIR/.." && pwd)

(
  cd "$REPO_ROOT/paper"
  rm -f a211420_formalized.pdf
  latexmk -pdf -interaction=nonstopmode -halt-on-error -file-line-error \
    a211420_formalized.tex
  test -s a211420_formalized.pdf
)

(
  cd "$REPO_ROOT/social"
  rm -f a211420_announcement.pdf a211420_announcement_1600x900.png
  latexmk -pdf -interaction=nonstopmode -halt-on-error -file-line-error \
    a211420_announcement.tex
  test -s a211420_announcement.pdf
  pdftoppm -png -singlefile -r 100 \
    a211420_announcement.pdf a211420_announcement_1600x900
  test -s a211420_announcement_1600x900.png
)

PNG="$REPO_ROOT/social/a211420_announcement_1600x900.png"
SIGNATURE=$(dd if="$PNG" bs=1 count=8 2>/dev/null | od -An -tx1 | tr -d ' \n')
WIDTH=$(dd if="$PNG" bs=1 skip=16 count=4 2>/dev/null | od -An -tx1 | tr -d ' \n')
HEIGHT=$(dd if="$PNG" bs=1 skip=20 count=4 2>/dev/null | od -An -tx1 | tr -d ' \n')

if [ "$SIGNATURE" != "89504e470d0a1a0a" ]
then
  echo "Invalid PNG signature: $SIGNATURE" >&2
  exit 1
fi

if [ "$WIDTH" != "00000640" ] || [ "$HEIGHT" != "00000384" ]
then
  echo "Unexpected PNG dimensions: width=0x$WIDTH height=0x$HEIGHT" >&2
  exit 1
fi

echo "Built paper PDF, social PDF, and verified 1600x900 PNG."
