# AI adversarial audits

Four hostile/adversarial checks were generated in fresh OpenAI GPT-5.6 Pro
runs.

- `referee_report_1.md` — polished report preserved from the original handoff.
- `referee_report_2.md` — second polished report from the original handoff.
- `fresh_pro_audit_3.txt` — later shared-page transcript; reports
  120,006,000 exact valuation triples with no counterexample.
- `fresh_pro_audit_4.txt` — later shared-page transcript; reports
  60,003,000 exact valuation triples with no counterexample.

They identified logical presentation repairs, especially proving integrality
before using integer divisibility, making valuation sums finite, recording
positivity, and checking the `q = 8r`, `i = r` boundary. Those points are
addressed in `A211420.lean`.

These reports are included for transparency. They are AI-generated analyses,
not human referee reports, not independent peer review, and not proof of
historical priority. Their literature searches are necessarily source-bounded.

The first two publication copies retain the report text while replacing inaccessible
temporary attachment links with repository-relative links. One exact-search
C++ source referenced in the second report was absent from the supplied
handoff; the report now states that explicitly instead of publishing a broken
link.

The two later transcripts preserve visible public-share text in plain-text
form, with their source URLs and capture date in the file headers. Their larger
search counts are claims in those transcripts; they are not presented as
locally replayed logs. The repository's reproducible checkers and logs remain
under `checks/`.

The Lean kernel check is the authoritative verification of the formal theorem.
