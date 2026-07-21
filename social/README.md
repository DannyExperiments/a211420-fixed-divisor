# A211420 announcement graphic

The 1600 by 900 PNG is a shareable paper-style summary of the exact theorem
formalized in [`../A211420.lean`](../A211420.lean). The PDF and PNG are built
from [`a211420_announcement.tex`](a211420_announcement.tex), which imports the
same [`../paper/verified_abstract_body.tex`](../paper/verified_abstract_body.tex)
used by the proof paper.

- [Announcement PNG](a211420_announcement_1600x900.png)
- [Announcement PDF](a211420_announcement.pdf)
- [Accessible alt text](ALT_TEXT.md)

From the repository root, rebuild all presentation assets with:

```sh
./scripts/build_presentation_assets.sh
```

The script requires `latexmk`, `pdflatex`, and `pdftoppm`. It fails unless the
PNG signature is valid and its dimensions are exactly 1600 by 900 pixels.
