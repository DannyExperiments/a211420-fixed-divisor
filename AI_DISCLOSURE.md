# AI disclosure

This project is AI-assisted and assigns contributions as precisely as the
available provenance permits.

- **OpenAI GPT-5.6 Pro:** generated the underlying ordinary-language
  mathematical argument and produced two adversarial audit runs.
- **OpenAI Codex:** produced the Lean 4 formalization, repaired it until the
  pinned Lean/mathlib project built cleanly, created the verification gate,
  and prepared the repository and publication files.
- **Danny Cabezas:** initiated the work, selected the problem and validation
  requirements, curated the artifacts, and published the repository.

The Lean build establishes that the stated formal declarations are accepted
by the Lean kernel with the pinned dependencies. It does not establish
historical priority, independent discovery, or human peer review.

The two files under `audits/` are preserved as AI-generated adversarial
reviews. They should not be described as reports by human referees or as
independent peer review. If more precise prompt, session, or model metadata is
later recovered, it should be added without rewriting the original reports.

Aristotle was also asked to attempt the formalization, but its output was not
used in the Lean artifact committed here. The repository must not attribute
this formalization to Aristotle unless a separate Aristotle result is later
received, checked, and clearly identified.
