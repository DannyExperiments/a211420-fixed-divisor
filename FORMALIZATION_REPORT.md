# A211420 formalization report

## Result

The exact strengthened theorem is kernel-checked. No mandatory hypothesis or
constant was changed. In particular, the constant is
`A211420.L r ^ r`, where

```lean
def A211420.L (r : ℕ) : ℕ := Nat.lcmUpto (8 * r - 1)
```

and mathlib defines `Nat.lcmUpto m` as the finite lcm over `Icc 1 m`.

The primary theorem is division-free. The natural-number quotient is defined
only after factorial-ratio exactness has been proved.

## Reproducible environment

- Lean: `4.30.0`
- Lean commit: `d024af099ca4bf2c86f649261ebf59565dc8c622`
- Target: `arm64-apple-darwin24.6.0`, Release build
- Lake: `5.0.0-src+d024af0`
- mathlib tag: `v4.30.0`
- mathlib commit: `c5ea00351c28e24afc9f0f84379aa41082b1188f`
- `lake-manifest.json` SHA-256 at dependency resolution:
  `768165e9bf27433856a5be4dbbf46e3037c0da71001979aa0fdc6aa269ac6fe7`

The toolchain is pinned by `lean-toolchain`; mathlib is pinned by
`lakefile.lean` and resolved in `lake-manifest.json`.

## Fully qualified theorem names

```lean
A211420.integral_cross
  (n : ℕ) : A211420.ADen n ∣ A211420.ANum n

A211420.factorization_ANum_eq_ADen_add_landau
  (n p b : ℕ) (hp : p.Prime) (hb : 8 * n < b) :
  (A211420.ANum n).factorization p =
    (A211420.ADen n).factorization p +
      ∑ j ∈ Finset.Ico 1 b, A211420.landau n (p ^ j)

A211420.strengthened_cross
  (n r k : ℕ) (hr : 0 < r)
  (hk : k = 1 ∨ k = 2 ∨ k = 3) :
  A211420.D k r n * A211420.ADen n ∣
    A211420.L r ^ r * A211420.ANum n

A211420.constant_pos
  (r : ℕ) (hr : 0 < r) : 0 < A211420.L r ^ r

A211420.ADen_mul_a
  (n : ℕ) : A211420.ADen n * A211420.a n = A211420.ANum n

A211420.strengthened
  (n r k : ℕ) (hr : 0 < r)
  (hk : k = 1 ∨ k = 2 ∨ k = 3) :
  A211420.D k r n ∣ A211420.L r ^ r * A211420.a n
```

An independent `#print axioms` pass reported only `propext`,
`Classical.choice`, and `Quot.sound`, the standard logical axioms used by
mathlib. No project axiom was introduced.

## Proof architecture

1. Natural-number quotient decomposition reduces each Legendre summand to
   the residue `n % q`.
2. Exact floor formulas for coefficients 2, 3, and 4 prove the Landau
   contribution is nonnegative and is positive on the four required
   half-open support intervals.
3. `A211420.support_of_large_dvd` proves that if `q ≥ 8*r` divides
   `k*n+i`, with `1 ≤ i ≤ r` and `k ∈ {1,2,3}`, then the residue is in the
   support. The proof includes equality at `q = 8*r`.
4. `Nat.factorization_factorial` proves the exact factorial-ratio valuation
   identity, from which `integral_cross` follows.
5. The valuation of the consecutive product is written as a finite double
   count of prime powers. Large prime powers occur in at most one factor and
   are paid by the Landau contribution. Small prime powers are bounded by
   `r * Nat.log p (8*r-1)`.
6. `Nat.factorization_lcmUpto` identifies that last quantity with the
   valuation of `L r ^ r`. `Nat.factorization_prime_le_iff_dvd` yields the
   cross-multiplied divisibility.
7. Exact quotient recovery and positive cancellation give the quotient
   theorem.

## Separate Aristotle implementation

Aristotle (Harmonic) returned a separate second complete Lean source after the
primary Codex formalization was finished:

- Dashboard request:
  `9c4e3070-8022-48f4-9c6f-1c1113b7b668`
- Aristotle run:
  `f56f7c36-ccd3-42d3-8016-ceb9a570da6f`
- Exact downloaded archive SHA-256:
  `77f332335d74a233ed1f231e8ca26f303d7adcc39f73d5edea0d83b7e9875d38`
- Original pins: Lean 4.28.0 and mathlib v4.28.0.
- Original `Main.lean` SHA-256:
  `e89ef8dd6b3cec62dfabdcb0bc45c674679875c9e0ca6e5495281c90e7f60313`

The unchanged 278-line `independent/aristotle/Main.lean` also compiles with
this repository's Lean 4.30.0 and mathlib v4.30.0 environment. Its fully
qualified result names are:

```lean
A211420.integral_cross
A211420.strengthened_cross
A211420.constant_pos
A211420.strengthened
```

It uses a direct factorial-interval divisibility route with a
`floor_step_bound` lemma, rather than the primary source's finite
prime-power double-count architecture. The exact upstream archive, source,
TeX result, summary, README, and project pins are preserved under
`independent/aristotle/`.

The exact Aristotle input prompt could not be recovered: the dashboard shows
only the truncated title “Formalize and kernel-check the following exact ...”.
The repository therefore does not claim independent generation or independent
reproduction. This is a second machine-generated formalization and a separate
compile check. It is not a dependency of the already completed
`A211420.lean`, human peer review, or evidence of historical priority. See
`independent/aristotle/PROVENANCE.md`.

## Mathlib API choices and refactorings

- The handoff's range-based lcm scaffold was replaced by the extensionally
  exact `Nat.lcmUpto (8*r-1)`. This exposes the existing theorem
  `Nat.factorization_lcmUpto` and does not change the mathematical constant.
- `Nat.factorization`, rather than `padicValNat`, was used because mathlib
  supplies both `Nat.factorization_factorial` and the direct divisibility
  criterion `Nat.factorization_prime_le_iff_dvd`.
- Rational floors were avoided in the executable proof. The four support
  intervals are represented by equivalent integer inequalities, which makes
  the endpoint conventions kernel-visible.
- A common finite exponent bound is used only to make Legendre and product
  sums finite. It does not perform bounded enumeration or replace the
  universal argument.

## Verification

Primary clean command:

```bash
./scripts/verify.sh
```

Final status: exit `0`. It runs `lake build`, compiles the unchanged
Aristotle implementation with `lake env lean independent/aristotle/Main.lean`,
and rejects the forbidden proof tokens/declarations in project `*.lean`
files while excluding `.lake/` and `.git/`.

After all publication repairs and installation of the TeX-built PDF, the
same command again exited `0`: all 2,721 primary build jobs completed, the
separate Aristotle source compiled with warnings only, and the forbidden-
source gate passed. `shasum -a 256 -c CHECKSUMS.sha256` also exited `0`.
A repository-wide hygiene scan found no workstation paths, Codex-internal
paths, private-key headers, GitHub-token prefixes, or OpenAI-key prefixes.
The preserved Aristotle archive was listed before extraction, contained only
eight regular relative-path files, and its extracted `Main.lean` had no
forbidden proof tokens or credential/path patterns.

GitHub Actions additionally runs the official `leanprover/lean-action@v1`
with `leanchecker: true`. On Lean 4.30 this invokes the bundled `leanchecker`
to replay the compiled module through the Lean kernel, guarding against an
invalid environment assembled by metaprogramming.

After integrating the separate Aristotle source, Lean workflow run
`29845929949` succeeded in 5m 24s at commit
`dd70f2e1c7a02dda1dfbba7a7ca8cd13c91ec9d7`. It completed the primary
build, bundled-kernel replay, second-source compile, and forbidden-source
gate.

The publication-repair PDF workflow run `29849862149` succeeded in 1m 44s
at commit `c1e216eaf027b23fd770e14094156ca3fec5f3e8`. Artifact
`8502918985` had ZIP SHA-256
`5c5aa502351111c1d355b00cde6ef5b2c42d86db6aca8b675e9c7612f8de8c23`.
The extracted PDF has SHA-256
`90103b8ae0d0808192672bbbdb50e20dd2e0a2fa342c97f2a2bf7df3dbe2137e`,
identifies `pdfTeX-1.40.29` as producer, and was committed unchanged after all
four pages were rendered and visually inspected.

After a current-branch display-name redaction, PDF workflow run
`29853681380` succeeded in 1m 43s at commit
`8fe77a1bf693b830e977a94a31945c71d50d5485`. Artifact `8504430357` had
ZIP SHA-256
`e64c94435646bf3ba4e18c87b5477a0e3351b2f906f50bfd16556001ffbede0c`.
The extracted four-page PDF had SHA-256
`9513a6b40dcca52bdf69bb4c2f19fb141b2d5a59f19fda18aae2395a237255f3`,
identifies `pdfTeX-1.40.29` as producer, and its revised title page was
rendered and visually inspected before the then-current PDF was replaced.
This artifact is historical and was superseded by the three-page `amsart`
paper recorded below.

An external `nanoda` check was also attempted with `nanoda-allow-sorry:
false` in workflow run `29841907020`. The ordinary `lake build` succeeded
(`2,721` jobs), `lean4export` detected and exported module `A211420`, and
then `nanoda` 0.3.2 stopped before type-checking with `Error: invalid digit
found in string` while parsing Lean 4.30's export. This is recorded as a
checker/toolchain compatibility failure, not as successful independent
verification and not as a failure of the Lean proof.

The exact public signatures and axiom dependencies were also checked with a
temporary import-only audit file; that file was removed after the check.

### Historical publication-repair CI evidence

This subsection records the final CI evidence for the earlier four-page
publication-repair artifact. Its TeX/PDF hashes are retained for chronology
only and are superseded by the `amsart` rewrite recorded below. The Lean-source
hash remains current.

The artifact-bearing publication-repair commit is
`fadfe86329237b644ba8cfe94acdcbad69c12dc9`. This is the last repair commit
that changes the proof PDF, workflow, checksums, command ledger, or this
report before CI evidence was recorded. Both required workflows were manually
dispatched on that exact commit and completed successfully:

- Lean verification run
  [`29850516799`](https://github.com/DannyExperiments/a211420-fixed-divisor/actions/runs/29850516799):
  `workflow_dispatch`, success, total duration 5m 6s; primary build, bundled
  Lean kernel replay, separate Aristotle compile, and forbidden-source gate.
- PDF build run
  [`29850538347`](https://github.com/DannyExperiments/a211420-fixed-divisor/actions/runs/29850538347):
  `workflow_dispatch`, success, total duration 2m 36s. Artifact
  `8503209554` has ZIP SHA-256
  `57b3d812f7b1149a9be48490ab0bb0258f7cd406f0523af6d08b617295fb25ec`.

The subsequent commit that adds these run identifiers is evidence-only; it
does not change the Lean source, TeX source, committed PDF, workflows, or
pinned environment. A commit cannot contain its own SHA, so the report names
the exact artifact-bearing repair commit on which the recorded runs executed.

Historical publication-repair SHA-256 digests:

- `A211420.lean`: `96a2f752cd8f0331a6b5cf8d3a431df4a00f5e905b212691e408028f5937b186`
- `scripts/verify.sh`: `5436609f463658ac1ec6352ea1c98ab151f14eb77af78667491ea52f5396182a`
- `lake-manifest.json`: `768165e9bf27433856a5be4dbbf46e3037c0da71001979aa0fdc6aa269ac6fe7`
- `paper/a211420_formalized.tex` (superseded): `4aef7a0cc047e6f2e108d92bd9e2bcc65c572392cb7fff95b77ecbf2fbfffd73`
- `paper/a211420_formalized.pdf` (superseded): `9513a6b40dcca52bdf69bb4c2f19fb141b2d5a59f19fda18aae2395a237255f3`
- `independent/aristotle/Main.lean`: `e89ef8dd6b3cec62dfabdcb0bc45c674679875c9e0ca6e5495281c90e7f60313`
- Aristotle source archive: `77f332335d74a233ed1f231e8ca26f303d7adcc39f73d5edea0d83b7e9875d38`

See `COMMAND_LOG.md` for the chronological shell-command and exit-status
ledger, including failed intermediate builds.

## Files produced or changed

- `A211420.lean` — complete formal development.
- `lean-toolchain` — Lean 4.30.0 pin.
- `lakefile.lean` — mathlib v4.30.0 pin and library target.
- `lake-manifest.json` — resolved dependency commits.
- `scripts/verify.sh` — build and source-integrity gate.
- `paper/a211420_formalized.tex` — verified note.
- `paper/a211420_formalized.pdf` — three-page TeX-generated `amsart` proof
  artifact.
- `independent/aristotle/` — separate second machine-generated Lean proof,
  `PROVENANCE.md`, and exact upstream project archive.
- `audits/fresh_pro_audit_3.txt` and `fresh_pro_audit_4.txt` — two later
  GPT-5.6 Pro shared-page audit transcripts.
- `FORMALIZATION_REPORT.md` — this report.
- `COMMAND_LOG.md` — command ledger.
- `.gitignore` — build and TeX artifacts.

## TeX/PDF status

`paper/a211420_formalized.pdf` is the three-page A4 `amsart` artifact produced
from the committed TeX by TeX Live 2026 on Debian in GitHub Actions run
`29860316672`. Its SHA-256 is
`b8e8a49161e0d5ec65153f1e1762ec4a7e60867657aefebcec6a9ba40e827033`,
and its producer is `pdfTeX-1.40.29`. All three pages were rendered and
visually inspected. The workflow deletes the pre-existing committed PDF before
compilation and uploads the newly built file, preventing a stale binary from
passing as a successful TeX build.

## Remaining unformalized extensions

- Minimality or sharpness of the constant `L r ^ r`.
- Additional backward-product and first-order divisibilities appearing in
  the supplied draft.
- Exhaustive historical-priority verification. The supplied searches found
  no prior source for the exact strengthening, but this is background, not a
  Lean theorem or a priority claim.

None of these extensions is part of the mandatory theorem.

## Publication-quality `amsart` rewrite

The mathematical paper was rewritten on branch `rewrite-paper-amsart` as a
conventional, concise number-theory article using `amsart`, A4 paper, and
one-inch margins. The rewrite changes exposition only. It retains exactly the
proved theorem, the integrality-before-divisibility order, the prime-power
argument, the `q = 8*r` endpoint, positivity of `L r ^ r`, and the established
prior-work boundary. No unformalized extension was added.

`A211420.lean` remained byte-for-byte unchanged before and after the rewrite at
SHA-256
`96a2f752cd8f0331a6b5cf8d3a431df4a00f5e905b212691e408028f5937b186`.
The separate Aristotle source, theorem signatures, Lean toolchain, mathlib
pin, and Lake files were likewise unchanged.

The former paper was a four-page US-letter article. The revised paper is a
three-page A4 `amsart` article; clarity was preferred to artificial padding to
the suggested five-to-eight-page range. It has a five-sentence abstract, three
numbered sections, two supporting lemmas, one main theorem, and a conventional
bibliography. The final source and installed PDF digests are:

- `paper/a211420_formalized.tex`:
  `b98a2386934114d990ede2ba319823d6c7e9518a3ce9f33e68d70c89919ce404`;
- `paper/a211420_formalized.pdf`:
  `b8e8a49161e0d5ec65153f1e1762ec4a7e60867657aefebcec6a9ba40e827033`.

PDF workflow run
[`29860316672`](https://github.com/DannyExperiments/a211420-fixed-divisor/actions/runs/29860316672)
compiled the final source with `pdfTeX-1.40.29` and strict `latexmk` flags.
Artifact `8507045231` had ZIP SHA-256
`669a607ee9d1a79cc666f77e168ebba3e72a38732d3a17a14b291be19a7d621c`.
The final TeX pass had no unresolved references and no overfull or underfull
boxes. All three pages were rendered and inspected at high resolution: no
clipping, malformed formula, bad page break, isolated heading, cramped text,
or excessive-width equation was found. `pdftotext` extraction was also
inspected and contained the complete theorem, interval table, endpoint
sentence, formal theorem names, and bibliography.
