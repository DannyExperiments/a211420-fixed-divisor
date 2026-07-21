# A211420 fixed-divisor theorem

[![Lean verification](https://github.com/DannyExperiments/a211420-fixed-divisor/actions/workflows/lean.yml/badge.svg)](https://github.com/DannyExperiments/a211420-fixed-divisor/actions/workflows/lean.yml)
[![PDF build](https://github.com/DannyExperiments/a211420-fixed-divisor/actions/workflows/pdf.yml/badge.svg)](https://github.com/DannyExperiments/a211420-fixed-divisor/actions/workflows/pdf.yml)

This repository contains a readable mathematical proof and a kernel-checked
Lean 4 formalization of the following strengthening of the fixed-divisor
conjecture recorded in OEIS A211420.

For

\[
a_n=\frac{(8n)!n!}{(4n)!(3n)!(2n)!},\qquad
L_r=\operatorname{lcm}(1,2,\ldots,8r-1),
\]

the formalized theorem states that, for every `n >= 0`, `r >= 1`, and
`k in {1,2,3}`,

\[
\prod_{i=1}^{r}(kn+i)\mid L_r^r a_n.
\]

The Lean development first proves factorial-ratio integrality and the
division-free statement

\[
\left(\prod_{i=1}^{r}(kn+i)\right)(4n)!(3n)!(2n)!
\mid L_r^r(8n)!n!,
\]

then derives the quotient corollary. It also proves `L_r^r > 0`.

## Known background and contribution

The integrality of `a_n` was already known: it is the `a = 4, b = 1`
specialization of family (8) in Jonathan W. Bober, “Factorial ratios,
hypergeometric series, and a family of step functions,” *Journal of the
London Mathematical Society* 79 (2009), Theorem 1.2
([arXiv:0709.1977](https://arxiv.org/abs/0709.1977),
[DOI 10.1112/jlms/jdn078](https://doi.org/10.1112/jlms/jdn078)).
This repository formalizes that integrality rather than assuming it.

The additional result proved here is the explicit uniform fixed divisor
`C(k,r) = L_r^r` for every `k ∈ {1,2,3}` and `r ≥ 1`. The repository
does not claim that this constant is minimal or historically new.

## Two primary files

- [Readable solution PDF](paper/a211420_formalized.pdf)
- [Lean formalization](A211420.lean)

## Verify locally

The project pins Lean 4.30.0 and mathlib v4.30.0.

```bash
./scripts/verify.sh
```

The verification script runs `lake build` and rejects `sorry`, `admit`, new
project axioms, and unsafe declarations in project Lean files. GitHub CI also
replays the compiled module through Lean 4.30's bundled `leanchecker`.

The principal declarations are:

- `A211420.integral_cross`
- `A211420.strengthened_cross`
- `A211420.constant_pos`
- `A211420.ADen_mul_a`
- `A211420.strengthened`

## Independent Aristotle formalization

Aristotle (Harmonic) independently generated a second Lean proof after the
primary Codex formalization was complete. Its exact downloaded archive,
original Lean 4.28.0 project metadata, and 278-line `Main.lean` are preserved
under [`independent/aristotle/`](independent/aristotle/). The unchanged
source also compiles under this repository's Lean/mathlib 4.30.0 environment;
`./scripts/verify.sh` checks both implementations.

This is evidence of independent machine reproduction, not human peer review
and not a dependency of the primary proof.

## Computational verification

The exact C++ valuation checker
[`checks/A211420_padic_audit.cpp`](checks/A211420_padic_audit.cpp) tested
`0 ≤ n ≤ 10000`, `1 ≤ r ≤ 1000`, and all three values of `k`: 30,003,000
triples and 75,347,906 prime-valuation updates, with no counterexample. A
separate direct Python checker tested 27,180 triples and 2,636,460 prime
inequalities. Sources and logs are preserved in [`checks/`](checks/).

These finite computations are corroborative only. The Lean theorem is
universal and does not use finite checking as proof.

## AI disclosure and attribution

The underlying ordinary-language mathematical argument was generated with
OpenAI GPT-5.6 Pro. OpenAI Codex produced and kernel-checked the Lean 4
formalization and prepared this repository. Danny Cabezas initiated, curated,
and published the project.

Four GPT-5.6 Pro adversarial audit runs are preserved in [`audits/`](audits/).
They are AI-generated checks, not human peer review. The two fresh instances
reported larger exact searches and reached the same corrected-theorem verdict;
their shared-page transcripts are archived verbatim in plain text.

See [AI_DISCLOSURE.md](AI_DISCLOSURE.md) for the full contribution statement.

## Scope

The displayed theorem is kernel-checked. This repository does **not** claim:

- historical priority or a certified first proof;
- human peer review;
- minimality of the constant `L_r^r`; or
- formal verification of additional variants mentioned in research drafts.

No prior source for the exact `L_r^r` strengthening was found in the supplied
searches, but absence from a bounded search is not evidence of originality.
