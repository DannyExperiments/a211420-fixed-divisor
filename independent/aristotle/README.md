# Separate Aristotle formalization

Aristotle (Harmonic) generated this separate second machine formalization,
which was received after the primary Codex proof in the repository had already
been completed.

- Dashboard request:
  <https://aristotle.harmonic.fun/dashboard/requests/9c4e3070-8022-48f4-9c6f-1c1113b7b668>
- Aristotle run identifier:
  `f56f7c36-ccd3-42d3-8016-ceb9a570da6f`
- Downloaded archive:
  `source/9c4e3070-8022-48f4-9c6f-1c1113b7b668-aristotle.tar.gz`
- Archive SHA-256:
  `77f332335d74a233ed1f231e8ca26f303d7adcc39f73d5edea0d83b7e9875d38`
- Original environment: Lean 4.28.0 and mathlib v4.28.0.
- Repository compatibility check: the unchanged `Main.lean` compiles under
  Lean 4.30.0 and mathlib v4.30.0.

The exact theorem names in this implementation are:

- `A211420.integral_cross`
- `A211420.strengthened_cross`
- `A211420.constant_pos`
- `A211420.strengthened`

The source uses a direct factorial-interval divisibility route, including a
`floor_step_bound` lemma. This is structurally different from the primary
`A211420.lean` development.

The dashboard displays only the truncated task title “Formalize and
kernel-check the following exact ...”. The exact input prompt could not be
recovered, so the repository does not claim that this source was independently
generated or constitutes an independent reproduction. See `PROVENANCE.md`.

## Verify

From the repository root:

```bash
./scripts/verify.sh
```

The script first builds the primary Lake library and then executes:

```bash
lake env lean independent/aristotle/Main.lean
```

It also scans both implementations for forbidden proof escapes.

## Preserved upstream material

- `Main.lean` — unchanged Aristotle Lean source.
- `VERIFIED_RESULT.tex` — Aristotle's concise TeX result.
- `ARISTOTLE_SUMMARY.md` — Aristotle's generated run summary.
- `ORIGINAL_README.md` — Aristotle's generated attribution note.
- `lean-toolchain.original`, `lakefile.original.toml`, and
  `lake-manifest.original.json` — exact original project pins.
- `source/*.tar.gz` — exact downloaded project archive.

These files preserve a second machine-generated implementation and permit a
separate compile check. They are not human peer review, a priority
determination, or a dependency of the already completed primary formalization.
