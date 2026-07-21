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

## Two primary files

- [Readable solution PDF](paper/a211420_formalized.pdf)
- [Lean formalization](A211420.lean)

## Verify locally

The project pins Lean 4.30.0 and mathlib v4.30.0.

```bash
./scripts/verify.sh
```

The verification script runs `lake build` and rejects `sorry`, `admit`, new
project axioms, and unsafe declarations in project Lean files.

The principal declarations are:

- `A211420.integral_cross`
- `A211420.strengthened_cross`
- `A211420.constant_pos`
- `A211420.ADen_mul_a`
- `A211420.strengthened`

## AI disclosure and attribution

The underlying ordinary-language mathematical argument was generated with
OpenAI GPT-5.6 Pro. OpenAI Codex produced and kernel-checked the Lean 4
formalization and prepared this repository. Danny Cabezas initiated, curated,
and published the project.

Two GPT-5.6 Pro adversarial audit runs are preserved in [`audits/`](audits/).
They are AI-generated checks, not human peer review.

See [AI_DISCLOSURE.md](AI_DISCLOSURE.md) for the full contribution statement.

## Scope

The displayed theorem is kernel-checked. This repository does **not** claim:

- historical priority or a certified first proof;
- human peer review;
- minimality of the constant `L_r^r`; or
- formal verification of additional variants mentioned in research drafts.

No prior source for the exact `L_r^r` strengthening was found in the supplied
searches, but absence from a bounded search is not evidence of originality.
