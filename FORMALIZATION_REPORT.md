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

Final status: exit `0`. It runs `lake build` and rejects the forbidden proof
tokens/declarations in project `*.lean` files while excluding `.lake/` and
`.git/`.

GitHub Actions additionally runs the official `leanprover/lean-action@v1`
with `leanchecker: true`. On Lean 4.30 this invokes the bundled `leanchecker`
to replay the compiled module through the Lean kernel, guarding against an
invalid environment assembled by metaprogramming.

An external `nanoda` check was also attempted with `nanoda-allow-sorry:
false` in workflow run `29841907020`. The ordinary `lake build` succeeded
(`2,721` jobs), `lean4export` detected and exported module `A211420`, and
then `nanoda` 0.3.2 stopped before type-checking with `Error: invalid digit
found in string` while parsing Lean 4.30's export. This is recorded as a
checker/toolchain compatibility failure, not as successful independent
verification and not as a failure of the Lean proof.

The exact public signatures and axiom dependencies were also checked with a
temporary import-only audit file; that file was removed after the check.

Final artifact SHA-256 digests:

- `A211420.lean`: `96a2f752cd8f0331a6b5cf8d3a431df4a00f5e905b212691e408028f5937b186`
- `scripts/verify.sh`: `61158423f2e685dcbff86a3846aebce0be3ebd1c07d6468f58a63008fbd608df`
- `lake-manifest.json`: `768165e9bf27433856a5be4dbbf46e3037c0da71001979aa0fdc6aa269ac6fe7`
- `paper/a211420_formalized.tex`: `859efe84ee5c55655941ae432754224b1bc88fa2ea7cafbb93e290364e825f1c`
- `paper/a211420_formalized.pdf`: `1e028e7893dd0f044eb294843067a39c1e3adf6a2b88883a6b76ea3d631a1b1c`

See `COMMAND_LOG.md` for the chronological shell-command and exit-status
ledger, including failed intermediate builds.

## Files produced or changed

- `A211420.lean` — complete formal development.
- `lean-toolchain` — Lean 4.30.0 pin.
- `lakefile.lean` — mathlib v4.30.0 pin and library target.
- `lake-manifest.json` — resolved dependency commits.
- `scripts/verify.sh` — build and source-integrity gate.
- `paper/a211420_formalized.tex` — verified note.
- `paper/a211420_formalized.pdf` — five-page readable proof artifact.
- `FORMALIZATION_REPORT.md` — this report.
- `COMMAND_LOG.md` — command ledger.
- `.gitignore` — build and TeX artifacts.

## TeX/PDF status

`paper/a211420_formalized.pdf` is present and was visually inspected page by
page. No local TeX engine was available. The repository's GitHub Actions PDF
workflow compiled `paper/a211420_formalized.tex` successfully with TeX Live
2026 on Debian (workflow run `29839378058`, exit success), providing an
independent check that the TeX source builds cleanly.

## Remaining unformalized extensions

- Minimality or sharpness of the constant `L r ^ r`.
- Additional backward-product and first-order divisibilities appearing in
  the supplied draft.
- Exhaustive historical-priority verification. The supplied searches found
  no prior source for the exact strengthening, but this is background, not a
  Lean theorem or a priority claim.

None of these extensions is part of the mandatory theorem.
