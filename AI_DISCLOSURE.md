# AI disclosure

This project is AI-assisted and assigns contributions as precisely as the
available provenance permits.

- **OpenAI GPT-5.6 Pro:** generated the ordinary-language proof of the
  explicit `L_r^r` strengthening and produced four adversarial audit runs.
- **OpenAI Codex:** produced the primary Lean 4 formalization and repository
  infrastructure, repaired the source until the pinned project built cleanly,
  and invoked the verification toolchain. Lean's kernel checked the formal
  development in the pinned environment.
- **Aristotle (Harmonic):** generated a separate second machine
  formalization received after the primary Codex proof was complete. Its
  exact source archive and original Lean 4.28.0 project metadata are preserved
  under `independent/aristotle/`; its unchanged `Main.lean` also compiles
  under this repository's Lean/mathlib 4.30.0 environment.
- **Danny Cabezas:** initiated the work, selected the problem and validation
  requirements, curated the artifacts, and published the repository.

The Lean build establishes that the stated formal declarations are accepted
by the Lean kernel with the pinned dependencies. It does not establish
historical priority, independent discovery, or human peer review.

The four files under `audits/` are preserved as AI-generated adversarial
reviews. They should not be described as reports by human referees or as
independent peer review. The two later files are plain-text captures of public
shared pages and retain their source URLs.

The exact input prompt sent to Aristotle could not be recovered from the
dashboard, which displays only a truncated task title. The repository
therefore does not describe that source as independently generated or as an
independent reproduction. It is a separately identified implementation, not
a co-authored component of `A211420.lean` and not a dependency of the
already completed primary theorem. Its presence does not establish historical
priority, novelty, or human review.
