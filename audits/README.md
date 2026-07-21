# AI adversarial audits

The two reports in this directory are hostile/adversarial checks generated in
fresh OpenAI GPT-5.6 Pro runs before the Lean formalization was completed.

- `referee_report_1.md`
- `referee_report_2.md`

They identified logical presentation repairs, especially proving integrality
before using integer divisibility, making valuation sums finite, recording
positivity, and checking the `q = 8r`, `i = r` boundary. Those points are
addressed in `A211420.lean`.

These reports are included for transparency. They are AI-generated analyses,
not human referee reports, not independent peer review, and not proof of
historical priority. Their literature searches are necessarily source-bounded.

The publication copies retain the report text while replacing inaccessible
temporary attachment links with repository-relative links. One exact-search
C++ source referenced in the second report was absent from the supplied
handoff; the report now states that explicitly instead of publishing a broken
link.

The Lean kernel check is the authoritative verification of the formal theorem.
