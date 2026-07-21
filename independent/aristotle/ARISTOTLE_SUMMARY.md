# Summary of changes for run f56f7c36-ccd3-42d3-8016-ceb9a570da6f
Completed and kernel-checked the requested formalization.

Files:
- `RequestProject/Main.lean` — complete Lean source, with no `sorry`, `admit`, new axioms, unsafe declarations, or finite-computation universal proof.
- `VERIFIED_RESULT.tex` — concise TeX statement and clearly labelled background note.

Exact theorem names:
- `A211420.integral_cross`
- `A211420.strengthened_cross`
- `A211420.constant_pos`
- `A211420.strengthened`

The definitions are:
- `A211420.ANum`
- `A211420.ADen`
- `A211420.D`
- `A211420.L`
- `A211420.a`

The proof uses Legendre prime valuations, symbolic floor/residue inequalities (including the `q = 8*r` boundary), the exact lcm range `1, …, 8*r-1`, and cancellation from the primary cross-multiplied theorem. `a` is defined only after `integral_cross`.

Verification:
- The full project builds successfully.
- All four requested theorems were checked for transitive axioms; each uses only standard permitted axioms `propext`, `Classical.choice`, and `Quot.sound`.
- Source scans found no forbidden proof gaps or declarations.

Version used: Lean 4.28.0 with mathlib v4.28.0, the supported installed project version. The requested v4.30.0 was not available in this environment.